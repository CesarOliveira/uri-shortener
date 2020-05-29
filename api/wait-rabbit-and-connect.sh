nc -v -w 2  $RABBITMQ_HOST 5672  &>/tmp/$$temp_file;
OPEN_TO_RECEIVE_CONNECTIONS=`cat /tmp/$$temp_file | egrep '(succeeded|open)' |wc -l`;


until [ ! $OPEN_TO_RECEIVE_CONNECTIONS -lt 1 ]; do
  >&2 echo "rabbit is unavailable - sleeping 5 seconds"
  sleep 5

  nc -v -w 2  $RABBITMQ_HOST 5672  &>/tmp/$$temp_file;
  OPEN_TO_RECEIVE_CONNECTIONS=`cat /tmp/$$temp_file | egrep '(succeeded|open)' |wc -l`;
done

rm -f /tmp/$$temp_file;


>&2 echo "rabbit is up - connecting to hutch"

hutch
