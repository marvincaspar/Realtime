# Realtime chat / notification system
Sends messages to each connected client by using redis and nodejs

-------

This is a simple chat example.

## How it works

- `/config/initializers/redis.rb`- Init redis
- `/config/initializers/nodejs.rb`- Starts nodejs server automatically when starting rails server
- `/app/assets/javascripts/pushing.js` - Client connect to nodejs and gets chat messages through socket.io
- `/app/controllers/home_controller.rb` - `push` method: pushes new chat message to a redis channel, in this example to channel `user-1:notification`
- `/realtime/realtime-server.js` - Nodejs server which is listening to a redis channel. If there are new chat message, they are broadcast to each client via socket.io.

-------

If you have one redis channel for each user, you can switch this chat to a notification system. Set the redis channel something like `user-{{ user-id }}:notification`, `{{ user-id }}` must be replayed dynamicaly.
