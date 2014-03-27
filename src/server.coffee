redis   = require "node-redis"
restify = require "restify"

client = redis.createClient()

server = restify.createServer
  name    : "shuttle"
  version : "0.0.1"

server.use restify.acceptParser(server.acceptable)
server.use restify.bodyParser()
server.post '/:list', (req, res, next) ->
  if req.headers['user-agent'] is "nxlog-ce"
    client.rpush "shuttleReqs", req.body
  res.send 200
  next()
server.listen 3838, ->
  console.log "#{server.name} listening at #{server.url}"
