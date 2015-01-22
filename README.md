# Realtime
Sends notifications to each connected client by using redis and nodejs

-------

In this example all connected clients gets a notification if someone pushs something to redis.

## How it works

- `/config/initializers/redis.rb`- Init redis
- `/config/initializers/nodejs.rb`- Starts nodejs server automaticaly when starting rails server
- `/app/assets/javascripts/pushing.js` - Client connect to nodejs and gets notification through socket.io
- `/app/controllers/home_controller.rb` - `push` method: pushes some data to a redis channel, in this example to channel `user-1:notification`
- `/realtime/realtime-server.js` - Nodejs server which is listening to a redis channel. If there are new notifications, they are broadcast to each client via socket.io.
