
  class AnalyticsController < ApplicationController
    before_action :authorize_admin

    def top_earning_products
      data = Category.includes(products: :purchases).map do |category|
        top_product = category.products
                             .left_joins(:purchases)
                             .group("products.id")
                             .order("COUNT(purchases.id) DESC")
                             .first

        {
          category: category.name,
          product: top_product&.name,
          total_purchases: top_product&.purchases&.count || 0
        }
      end

      render json: data
    end

    def top_revenue_products_by_category
      data = Category.includes(products: :purchases).map do |category|
        top_products = category.products
                               .left_joins(:purchases)
                               .group("products.id")
                               .select("products.*, SUM(purchases.total_price) AS revenue")
                               .order("revenue DESC")
                               .limit(3)

        {
          category: category.name,
          top_products: top_products.map { |p| { name: p.name, revenue: p.revenue.to_f } }
        }
      end

      render json: data
    end

    def purchases
      purchases = Purchase.all
      purchases = purchases.where("created_at >= ?", params[:from]) if params[:from].present?
      purchases = purchases.where("created_at <= ?", params[:to]) if params[:to].present?

      if params[:category_id].present?
        purchases = purchases.joins(product: :categories)
                              .where(categories: { id: params[:category_id] })
      end

      purchases = purchases.where(client_id: params[:client_id]) if params[:client_id].present?
      purchases = purchases.where(admin_id: params[:admin_id]) if params[:admin_id].present?

      render json: purchases
    end

  def purchases_by_granularity
    from = params[:from]
    to = params[:to]
    granularity = params[:granularity]
    category_id = params[:category_id]

    allowed = %w[day month year]
    unless allowed.include?(granularity)
      return render json: { error: "Invalid granularity. Allowed values: #{allowed.join(', ')}" }, status: :bad_request
    end

    format =
      case granularity
      when "day"   then "YYYY-MM-DD"
      when "month" then "YYYY-MM"
      when "year"  then "YYYY"
      end

    purchases = Purchase.joins(product: :categories).where(created_at: from..to)
    purchases = purchases.where(categories: { id: category_id }) if category_id.present?

    grouped = purchases.group("TO_CHAR(purchases.created_at, '#{format}')").count

    render json: grouped
  end
  end
