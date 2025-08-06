class PurchaseMailer < ApplicationMailer
    def purchase_email(purchase)
        @purchase = purchase
        @product = purchase.product
        @creator = @product.creator

        admins = User.admins.where.not(id: @creator.id)

        mail(
        to: @creator.email,
        cc: admins.pluck(:email),
        subject: "Primera compra del producto #{@product.name}"
        )
  end
end
