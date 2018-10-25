// just helper class to hold object position on plane
class Point
{
	public var x:Float;
	public var y:Float;

	public function new(x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
	}
}

// just helper class to hold world bounds
class Rect
{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;

	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0)
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
}

class PlayerMovement extends hxd.App {

	// Light source for our scene
	var light : h3d.scene.DirLight;

	// player object, which we will controll
	var player : h3d.scene.Object;
	
	// just a cube representing floor
	var floor: h3d.scene.Object;

	// position of our player in the world
	var playerPosition:Point;
	// movement direction of player (angle in radians)
	var playerDirection:Float;

	// distance from camera to player
	var cameraDistance:Float;
	// camera height from floor level
	var cameraHeight:Float;

	// model cache, used for model and animation loading
	var cache : h3d.prim.ModelCache;

	// tells us whether player is currently moving or not
	var isMoving:Bool = false;
	// current movement speed of player
	var movementSpeed:Float = 0.0;

	// some player movement characteristics
	var walkSpeed:Float = 0.02;
	var turnSpeed:Float = 0.01;

	var worldBounds:Rect;

	var walkingAnimation:h3d.anim.Animation;

	override function init() 
	{
		// let's create and setup lighing on the scene
		light = new h3d.scene.DirLight(new h3d.Vector( 0.3, -0.4, -0.9), s3d);
		light.enableSpecular = true;
		light.color.set(0.28, 0.28, 0.28);
		s3d.lightSystem.ambientLight.set(0.74, 0.74, 0.74);

		// load model and create player object
		cache = new h3d.prim.ModelCache();
		player = cache.loadModel(hxd.Res.Model);
		player.scale(1 / 20);
		player.rotate(0, 0, Math.PI / 2);
		s3d.addChild(player);

		playerPosition = new Point(player.x, player.y);
		playerDirection = Math.PI / 2; //0.0;

		walkingAnimation = cache.loadAnimation(hxd.Res.Model);

		worldBounds = new Rect(-10, -10, 20, 20);

		// create cube primitive which we will use for floor object
		var prim = new h3d.prim.Cube(worldBounds.width, worldBounds.height, 1.0);
		// translate it so its center will be at the center of the cube
		prim.translate( -0.5 * worldBounds.width, -0.5 * worldBounds.height, -0.5);
		// unindex the faces to create hard edges normals
		prim.unindex();
		// add face normals
		prim.addNormals();
		// add texture coordinates
		prim.addUVs();
		// access the logo resource and convert it to a texture
		var tex = hxd.Res.load("hxlogo.png").toImage().toTexture();
		// create a material with this texture
		var mat = h3d.mat.Material.create(tex);
		// create textured floor
		var floor = new h3d.scene.Mesh(prim, mat, s3d);
		// set the cube color
		floor.material.color.setColor(0xFFB280);
		// put it under player
		floor.z = -0.5;
		
		// setup camera params
		cameraDistance = 15;
		cameraHeight = 5;
		updateCamera();
	}
	
	override function update(dt:Float) 
	{
		// check whether player moves forward or backward
		var playerSpeed = 0.0;
		if (hxd.Key.isDown(hxd.Key.UP))
		{
			playerSpeed += 1;
		}
		if (hxd.Key.isDown(hxd.Key.DOWN))
		{
			playerSpeed -= 1;
		}

		// check if player is running
		var runningMultiplicator = 1.0;
		if (hxd.Key.isDown(hxd.Key.SHIFT))
		{
			// running forward should be faster than backward
			if (playerSpeed < 0)
			{
				runningMultiplicator = 1.3;
			}
			else
			{
				runningMultiplicator = 2;
			}
		}

		// check if player is turning
		if (hxd.Key.isDown(hxd.Key.LEFT))
		{
			playerDirection -= turnSpeed * runningMultiplicator;
		}
		if (hxd.Key.isDown(hxd.Key.RIGHT))
		{
			playerDirection += turnSpeed * runningMultiplicator;
		}

		if (playerSpeed != 0)
		{
			// update player's position if its moving
			playerSpeed *= runningMultiplicator;
			
			playerPosition.x += Math.cos(playerDirection) * walkSpeed * playerSpeed;
			playerPosition.y += Math.sin(playerDirection) * walkSpeed * playerSpeed;

			// Limit player movement, so it won't go out of world's bounds
			playerPosition.x = Math.min(worldBounds.x + worldBounds.width, playerPosition.x);
			playerPosition.x = Math.max(worldBounds.x, playerPosition.x);

			playerPosition.y = Math.min(worldBounds.y + worldBounds.height, playerPosition.y);
			playerPosition.y = Math.max(worldBounds.y, playerPosition.y);

			// and finally set it's position
			player.x = playerPosition.x;
			player.y = playerPosition.y;

			// change player's animation if its speed has been changed
			if (movementSpeed != playerSpeed)
			{
				if (playerSpeed > 0)
				{
					// playing animation for walking forward
					// if player is running or walking, then we need to adjust animations speed
					player.playAnimation(walkingAnimation).speed = runningMultiplicator;
				}
				else 
				{
					// need to play backward animation, but i don't have one
					// so i won't play anything :(
				}
				
				movementSpeed = playerSpeed;
			}

			isMoving = true;
		}
		else
		{
			// if player isn't moving we need to reset some of its params
			if (isMoving)
			{
				player.stopAnimation();
				// or migth play idle animation (use switchAnimation() method)...
			}
			
			movementSpeed = 0;
			isMoving = false;
		}
		
		// update player's rotation
		player.setRotation(0, 0, playerDirection + Math.PI / 2);
		
		// and don't forget to update camera's position
		updateCamera();
	}

	function updateCamera()
	{
		var cameraZ = cameraHeight;
		var cameraXYDist = Math.sqrt(cameraDistance * cameraDistance - cameraHeight * cameraHeight);
		var cameraXYAngle = Math.PI / 4;
		var cameraX = player.x - cameraXYDist * Math.cos(cameraXYAngle);
		var cameraY = player.y - cameraXYDist * Math.sin(cameraXYAngle);

		s3d.camera.pos.set(cameraX, cameraY, cameraZ);
		s3d.camera.target.set(player.x, player.y, player.z);
	}

	static function main() {
		hxd.Res.initEmbed();
		new PlayerMovement();
	}
}