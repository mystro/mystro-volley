class VolleyWorker
  extend Resque::Plugins::Logger
  @queue = :default

  class << self
    def perform(options={ })
      vu = Jobs::Volley::Update.create!
      vu.enqueue
      vm = Jobs::Volley::Meta.create!
      vm.enqueue
    rescue => e
      logger.error e.message
      logger.error e
    end
  end
end
