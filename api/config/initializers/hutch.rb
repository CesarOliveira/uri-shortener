client_logger = Logger.new("log/hutch.log")
Hutch::Config.set(:client_logger, client_logger)

Hutch::Config.set(:mq_exchange, ENV['RABBITMQ_EXCHANGE'])

Hutch::Config.set(:mq_host, ENV['RABBITMQ_HOST'])

Hutch::Config.set(:enable_http_api_use, false)
