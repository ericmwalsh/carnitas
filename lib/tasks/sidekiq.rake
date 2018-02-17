namespace :sidekiq do
  require 'sidekiq/api'

  desc "Wait until 'busy' queue is finished"
  task wait: :environment do
    Sidekiq::ProcessSet.new.each(&:quiet!)
    sleep(1) unless finished?
  end

  private

  def finished?
    ps = Sidekiq::ProcessSet.new
    return ps.size == 0 || ps.detect { |process| process['busy'] == 0 }
  end
end
