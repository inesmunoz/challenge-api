class Purchase < ApplicationRecord
  include Filterable
  #
  ## RELATIONS
  #
  belongs_to :client
  belongs_to :product

  #
  ## HOOKS
  #
  after_create :notify_admins_if_first_purchase, if: :first_purchase_of_product?

  private

  def first_purchase_of_product?
    Purchase.where(product_id: product_id).count == 1
  end

  def notify_admins_if_first_purchase
    PurchaseMailer.purchase_email(self).deliver_later
  end
end
