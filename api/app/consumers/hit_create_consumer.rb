require 'hutch'

class HitCreateConsumer
  include Hutch::Consumer
  consume 'hit.create'

  def process(message)
    data = message.body[:subject].symbolize_keys
    Hit::Create.new(data, HitRepository).save
  end
end
