class VolleyWorker
  extend Resque::Plugins::Logger
  @queue = :default

  class << self
    def perform(options={ })
      job = Jobs::Volley::Update.create!
      job.enqueue
    rescue => e
      logger.error e.message
      logger.error e
    end
  end
end