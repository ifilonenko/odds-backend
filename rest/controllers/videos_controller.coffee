var azure = require("azure");
var app = require('express')();
app.enable("jsonp callback");

class VideosController
  getURL: (req, res) =>
    url = blobService.generateSharedAccessSignature("container", req.params.file, {
        AccessPolicy : {
          Permissions : "rwdl",
          Expiry : getDate()
        }
      }
    );
    res.send({url: url.url()})

function getDate(){
  var date = new Date();
  date.setHours((date).getHours() + 1);
  return date;
}