require 'prawn'

class DailyPurchaseReportPdf
  def initialize(report_data, date)
    @report_data = report_data
    @date = date
  end

  def generate
    Prawn::Document.new do |pdf|
      pdf.text "Reporte de Compras - #{@date.strftime('%d/%m/%Y')}", size: 18, style: :bold
      pdf.move_down 20

      @report_data.each do |product, purchases|
        pdf.text "Producto: #{product.name}", size: 14, style: :bold
        pdf.text "Total de Compras: #{purchases.count}"
        pdf.move_down 10
      end
    end.render
  end
end