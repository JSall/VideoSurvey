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
}