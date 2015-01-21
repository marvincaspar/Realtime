class HomeController < ApplicationController
  def index
  end

  def push
    data = {
             notification: "Some notification #{Time.now}"
           }

    $redis.publish("user-1:notification", data.to_json)

    render nothing: true
  end
end
