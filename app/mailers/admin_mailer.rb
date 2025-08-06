class AdminMailer < ApplicationMailer
  def daily_purchase_report(report_data, date)
    @report_data = report_data
    @date = date
    admins = User.admins
    attachments["compras_#{date}.pdf"] = DailyPurchaseReportPdf.new(report_data, date).generate

    mail(
      to: admins.first.email,
      cc: admins[1..].map(&:email),
      subject: "Reporte de compras del #{@date.strftime('%d/%m/%Y')}"
    )
  end
end
