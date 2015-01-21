var user_id;
var server = require('http').createServer();
var io = require('socket.io')(server);
var redis = require('redis').createClient();


redis.on('pmessage', function(pattern, channel, message) {
  io.sockets.emit(channel.split(':')[1], JSON.parse(message));
});

io.on('connection', function(socket) {
  user_id = socket.handshake.query.user_id;
  // wildcard subscription whereas * stands for the event
  redis.psubscribe('user-' + user_id.toString() + ':*');

  socket.on('disconnect', function() {
    redis.punsubscribe('user-' + user_id.toString() + ':*');
    socket.disconnect();
  });
});

server.listen(5001);