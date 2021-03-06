﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--BootStrap CSS and JS-->
    <link rel="stylesheet" href=".\css\bootstrap.min.css" />
    <script src=".\js\jquery-3.2.1.min.js"></script>
    <script src=".\js\popper.min.js"></script>
    <script src=".\js\bootstrap.min.js"></script>
    <title>Video Survey</title>
</head>

<body>

    <script type="text/javascript">

        var videos = $.makeArray(<%=PlayerQueue%>);
        var screen;
        var i = 0
        function PlayVid() {
            $('#NextBtn').hide();

            if (i == videos.length) {
                $('#NextBtn').hide();
                $('#Reset').hide();
                $('#Submit').show();
            }

            screen.attr("src", "../vids/" + videos[i]);
            screen[0].load();

            if (screen[0].readyState <= 3) {
                screen.hide();
            }

            screen[0].oncanplaythrough = function () {
                screen.show();
                $('#PlayBtn').show();
            };
            screen[0].onended = function () {
                $('#NextBtn').show();
            };
            //screen[0].onpause = function () {
            //    $('#PlayBtn').show();
            //}
            //screen[0].onplay = function () {
            //    $('#PlayBtn').hide();
            //}
        }

        function Next() {
            i++;
            PlayVid();
        }

        function StartVid() {
            screen[0].play();
            $('#PlayBtn').hide();
        }

        function SubmitID() {

            var pID = $('#PartiID').val().trim();
            if (pID == null || pID == '' || pID.length != 4) {
                $('#PartIDError').show();
            }
            else {
                $('#IDModal').modal('hide');
                $('#PartIDError').hide();
                $("#ParticipantID").val(pID);
                $(document).keydown(function (event) {
                    var wasPaused = true;

                    if (!screen[0].paused) {
                        screen[0].pause();
                        wasPaused = false;
                    }

                    if (!$('#IDModal').is(':visible')) {
                        $('#console').append(screen[0].currentTime + ", " + event.key + ", " + videos[i]);
                    }

                    if (i != videos.length) {
                        $('#console').append("\n");
                    }

                    if (!wasPaused) {
                        screen[0].play();
                    }
                    return false;
                });
            }
        }

        $(document).ready(function () {
            screen = $('#mainScreen');
            $('#Submit').hide()
            $('#PartIDError').hide();
            $('#console').hide();
            $('#PlayBtn').hide();
            PlayVid();

            var c = $('#console').val().trim();
            if (c == null || c == '') {
                //$('#console').append("Current Time, Keystroke, Video Name\n")
                $('#IDModal').modal('show');
            }
            else {
                $('#CompleteModal').modal('show');
            }

        });


    </script>
    <form runat="server" id="mainForm">
        <%--<nav class="navbar navbar-inverse navbar-top">
            <div class="container">
                <div class="navbar-header">
                    <asp:Button runat="server" ID="DownloadData" CssClass="btn" OnClick="DownloadData_Click"  Text="Download Data" />
                </div>
                <div class="navbar-collapse  collapse">
                   
                </div>
               
            </div>
        </nav>--%>
        <br /><br />

        <div class="col-lg-2"></div>

        <div class="col-lg-6">
            <video id="mainScreen"
                width="1280" height="528">
            </video>
            <br />

            <div class="col-lg-4"></div>
            <div class="col-lg-4">
                <button type="button" id="PlayBtn" class="btn btn-small" onclick="StartVid()">Start Video <i class="glyphicon glyphicon-play-circle"></i></button><br />
                <asp:Button runat="server" ID="Submit" Text="Submit Data" CssClass="btn btn-lg btn-success" OnClick="Submit_Click"></asp:Button>
                <br />

                <textarea runat="server" id="console" readonly="true" style="color: grey; width: 652px; height: 179px;"></textarea><br />
                <button type="button" id="NextBtn" class="btn btn-small btn-success" onclick="Next()">Proceed</button><br />
               
            </div>
            <div class="col-lg-4"></div>
            <br />

            <input runat="server" id="ParticipantID" type="hidden" />

        </div>


        <div class="col-lg-6"></div>
    </form>
  
      <div id="IDModal" class="modal fade" data-backdrop="static"
        data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Please enter your 4-digit ID from Sona</h5>
                </div>
                <div class="modal-body">
                    <input id="PartiID" type="text" />
                    <p id="PartIDError" style="color:red;font-size:10px">Please enter a 4 digit ID</p>
                </div>
                <div class="modal-footer">
                    <button id="SubmitID" type="button" class="btn btn-secondary" onclick="SubmitID()">Enter</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="CompleteModal" class="modal fade" data-backdrop="static"
        data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">                    
                </div>
                <div class="modal-body">
                    <p>Trial complete. Please close this page.</p>
                </div>
                <div class="modal-footer">                                      
                </div>
            </div>
        </div>
    </div>
</body>
</html>
