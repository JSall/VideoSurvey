using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

public partial class _Default : System.Web.UI.Page
{
    public string PlayerQueue;

    protected void Page_Load(object sender, EventArgs e)
    {
        string serverRoot = Server.MapPath("~");

        VideoPlayOrder playerQueue = new VideoPlayOrder(serverRoot + "/vids");
        PlayerQueue = new JavaScriptSerializer().Serialize(playerQueue.VideoPathQueue.Select(f => f.Name));

    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        File.WriteAllText(Server.MapPath("~")+"results/" + ParticipantID.Value + ".csv", console.Value);
    }

    protected void DownloadData_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("Participant ID, TimeStamp, Keystroke, Video Name");
        foreach (var file in Directory.GetFiles(Server.MapPath("~") + "results"))
        {           
            string fn = new FileInfo(file).Name.Split('.').First();
            foreach (string l in File.ReadAllLines(file))
            {
                sb.AppendLine(fn + ", " + l);
            }
            
        }
        string path = Server.MapPath("~") + DateTime.Now.Month + "_" + DateTime.Now.Day + "_" + "Results.csv";
        File.WriteAllText(path, sb.ToString());
        FileInfo fi = new FileInfo(path);
        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=" + fi.Name);
        Response.AddHeader("Content-Length", fi.Length.ToString());
        Response.ContentType = "text/plain";
        Response.WriteFile(path);
        Response.End();
    }
}