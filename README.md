# Realtime
Sends notification to each connected client by using redis and nodejs


In this example the client is listen to a redis channel via nodejs. If the server sends a message to redis, nodejs is litening and broadcast the message to all listen clients.

- nodejs is only running over http but can expand to run on https too
- just listen to one channel for one user
