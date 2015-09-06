azure = require("azure");
app = require('express')();
app.enable("jsonp callback");

blobService = azure.createBlobService()
blobService.createContainerIfNotExists("container", (error) -> return)

createResourceName = (containerName, blobName, skipEncoding) ->
  # Resource name
  if !skipEncoding
    if blobName
      blobName = encodeURIComponent(blobName)
      blobName = blobName.replace(/%2F/g, '/')
      blobName = blobName.replace(/%5C/g, '/')
      blobName = blobName.replace(/\+/g, '%20')
  resourceName = containerName + '/' + blobName
  if !containerName or containerName == '$root'
    resourceName = blobName
  if !blobName
    resourceName = containerName
  resourceName

serviceProperties = {
  Cors: {
    CorsRule: [
      {
        AllowedOrigins: ['*'],
        AllowedMethods: ['GET', 'PUT'],
        AllowedHeaders: ['*'],
        ExposedHeaders: ['*'],
        MaxAgeInSeconds: 1800
      }
    ]
  }
}

class VideosController
  getURL: (req, res) =>
    blobService.setServiceProperties(serviceProperties, (err, res, resp) =>
      return
    )
    url = blobService.generateSharedAccessSignature("container", req.params.file_name, {
        AccessPolicy : {
          Permissions : "rwdl",
          Expiry : getDate()
        }
      }
    );
    resourceName = createResourceName('container', req.params.file_name)
    fullPath = blobService.host.primaryHost + resourceName + '?' + url
    console.log('Fullpath: ' + url)
    res.send({url: fullPath})

getDate =  => 
  date = new Date();
  date.setHours((date).getHours() + 1);
  return date;

module.exports = new VideosController()