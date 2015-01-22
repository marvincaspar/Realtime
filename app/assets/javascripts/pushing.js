var socket;

$(document).ready(function() {
  /*
   * Establish connection to NodeJS pushing service
   */
  if (logged_in) {
    socket = io.connect(
      'http://localhost:5001/?user_id=' + user_id,
      {
        reconnectionDelay: 5000,
        reconnectionDelayMax: 10000,
        reconnectionAttempts: 3
      }
    );
    socket.on('connect', function() {
    });

    socket.on('connect_error', function(e) {
      console.log("Can't connect to Node.js");
    });
  }
});

/*
 * Notifications
 */
(function() {
  function doSomething(data) {
    console.log(data);
    $('.push-wrapper').append(data.notification + '<br/>');
  }

  // Hook to NodeJS Queue
  $(document).ready(function() {
    if (logged_in) {
      socket.on('notification', function(data) {
        doSomething(data);
      });
    }
  });
})();

