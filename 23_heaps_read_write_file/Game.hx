import sys.io.File;
import sys.FileSystem;

class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    override function init() 
    {
        var t = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        
        // this file will be stored / searched for in app directory
        var fileName = "data.txt";
        var readNum = 0;

        if (!FileSystem.exists(fileName))
        {
            // if there is no such file, then let's create it
            File.saveContent(fileName, 'My data...\n${readNum}');
        }
        else 
        {
            // if there is such file, then let's read its contents, trace it and modify it a bit
            var content = File.getContent(fileName);
            
            t.text = content;

            var lines = content.split("\n");
            readNum = Std.parseInt(lines[1]);
            trace("readNum: " + readNum);
            readNum++;

            content = lines[0] + "\n" + readNum;
            File.saveContent(fileName, content);
        }
    }
}