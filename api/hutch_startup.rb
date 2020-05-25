require 'bunny'

retries = 0
max_retries = 100

begin
  connection = Bunny.new("amqp://guest:guest@#{ENV['RABBITMQ_HOST']}")
  connection.start
  connection.close

  puts 'Conected to rabbitmq with success'
  exec('hutch --require app/consumers/*.rb')
rescue Bunny::TCPConnectionFailedForAllHosts, AMQ::Protocol::EmptyResponseError
  if retries <= max_retries
    retries += 1
    sleep 2**retries

    puts "atempt #{retries} to connect rabbitmq"
    retry
  else
    raise "Fail to connect tp Rabbitmq. Max of #{max_retries} attempts achivied"
  end
end
