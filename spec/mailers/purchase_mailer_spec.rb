require "rails_helper"

RSpec.describe PurchaseMailer, type: :mailer do
  describe 'purchase_email' do
    let!(:creator) { create(:user) }
    let!(:product) do
      PaperTrail.request(whodunnit: creator.id.to_s) do
        create(:product)
      end
    end
    let(:client) { create(:client) }
    let!(:purchase) { create(:purchase, client: client, product: product) }

    subject(:mail) { described_class.purchase_email(purchase) }

    it 'renders the headers' do
      expect(mail.subject).to eq("Primera compra del producto #{product.name}")
      expect(mail.to).to eq([creator.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include("Primera compra del producto")
      expect(mail.body.encoded).to include(product.name)
    end
  end
end