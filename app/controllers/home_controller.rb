class HomeController < ApplicationController
  def index
  end

  def push
    data = {
             notification: "<strong>user:</strong> #{ params[:message] }"
           }
           
    $redis.publish("chat", data.to_json)
    # $redis.publish("user-1:notification", data.to_json)

    render nothing: true
  end
end
