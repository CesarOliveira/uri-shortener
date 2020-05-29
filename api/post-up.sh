bundle install --quiet

if [ "$SERVICE_TYPE" = "worker" ]; then
  sh wait-rabbit-and-connect.sh
else
  rm -f tmp/pids/server.pid
  rails s -b 0.0.0.0 -p 3000
fi
