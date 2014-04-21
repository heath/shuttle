redis   = require "node-redis"
restify = require "restify"

client = redis.createClient()

server = restify.createServer
  name    : "shuttle"
  version : "0.0.2"

server.use restify.acceptParser(server.acceptable)
server.use restify.bodyParser()

server.post '/:origin', (req, res, next) ->
  switch req.params.origin
    when "eventlog" then client.rpush "shuttle-eventlog", req.body
    when "iis" then client.rpush "shuttle-iis", req.body
    when "nxlog" then client.rpush "shuttle-nxlog", req.body
  res.send 200
  next()

server.listen 3000, -> console.log "#{server.name} on #{server.url}"
