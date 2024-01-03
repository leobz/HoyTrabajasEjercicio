pid_file="tmp/pids/server.pid"

# stops the server if it is already running
if [ -e "$pid_file" ]; then
  pid=$(cat "$pid_file")
  kill -9 "$pid"
  wait "$pid"
  rm "$pid_file"
fi

rails db:create db:migrate db:seed
rails server -b 0.0.0.0