class NodeJsRealtimeServer < Rails::Railtie
  unless File.basename($0).eql?('rake') || defined?(Rails::Console) || Rails.env.test?
    config.after_initialize do
      # Define full path to Node.js app
      path = "#{ Rails.root }/realtime/realtime-server.js"

      puts "------------"
      puts "Node.js realtime server starting ..."

      binary = ""

      bin = ["nodejs", "node"]
      bin.each do |b|
        cmd = `#{ b } -v`
        unless cmd.nil?
          binary = b
          break
        end
      end

      abort "No Node.js installation found on this system!".red.bold if binary.empty?

      # Put together shell command for extracting PID of Node.js app and save it for further processing
      cmd = "ps aux | grep '[#{ binary }] #{ path }' | awk '{ print $2 }'"
      pid = `#{ cmd }`

      # Shutdown current Node.js instance if one is running
      if pid.present?
        puts "* ... server already running with PID #{ pid.to_i } - killing it ...".yellow
        system "kill #{ pid }"
        sleep 5
      end

      # Start app
      puts "* ... starting server".green
      system "#{ binary } #{ path } &"
      puts "------------"
    end
  end
end