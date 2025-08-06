class DailyPurchaseReportJob
    include Sidekiq::Worker

  def perform
    start_time = 1.day.ago.beginning_of_day
    end_time = 1.day.ago.end_of_day

    purchases = Purchase.includes(:product).where(created_at: start_time..end_time)

    report_data = purchases.group_by(&:product)

    AdminMailer.daily_purchase_report(report_data, start_time.to_date).deliver_now
  end
end