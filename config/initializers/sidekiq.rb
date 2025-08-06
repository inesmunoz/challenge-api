require 'sidekiq-cron'


Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }

  config.on(:startup) do
    Sidekiq::Cron::Job.load_from_hash!({
      'daily_purchase_report' => {
        'class' => 'DailyPurchaseReportJob',
        'cron'  => '0 8 * * *' # Cada día a las 8 AM UTC
      }
    })
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end