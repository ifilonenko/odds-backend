azure = require("azure");
app = require('express')();
app.enable("jsonp callback");

blobService = azure.createBlobService()
blobService.createContainerIfNotExists("container", (error) -> return)

class VideosController
  getURL: (req, res) =>
    url = blobService.generateSharedAccessSignature("container", req.params.file_name, {
        AccessPolicy : {
          Permissions : "rwdl",
          Expiry : getDate()
        }
      }
    );
    console.log('url: ' + typeof url)
    res.send({url: url.url()})

getDate =  => 
  date = new Date();
  date.setHours((date).getHours() + 1);
  return date;

module.exports = new VideosController()