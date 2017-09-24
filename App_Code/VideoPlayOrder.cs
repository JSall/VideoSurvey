using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VideoPlayOrder
/// </summary>
public class VideoPlayOrder
{
    public IEnumerable<FileInfo> VideoPathQueue;
    
    public VideoPlayOrder(string VidDir)
    {
        //init
        VideoPathQueue = new List<FileInfo>(10);
        Random ran = new Random();

        //read and shuffle videos
        VideoPathQueue = new DirectoryInfo(VidDir).EnumerateFiles()
            .OrderBy(v => ran.Next());
    }
}