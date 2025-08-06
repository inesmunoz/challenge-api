class Product < ApplicationRecord
    include Filterable
    has_paper_trail

    #
    ## RELATIONS
    #
    has_many :categorizations, dependent: :destroy
    has_many :categories, through: :categorizations
    has_many :purchases

    #
    ## VALIDATIONS
    #
    validates :name, presence: true
    validates :price,presence: true, numericality: { greater_than_or_equal_to: 0 }

    #
    ## FILTERS
    #
    scope :category_id, ->(id) {
       joins(:categories).where(categories: { id: id })
    }

    scope :min_price, ->(price) {
        where("price >= ?", price)
    }

    scope :max_price, ->(price) {
        where("price <= ?", price)
    }

    scope :with_name, ->(value) { where(name: value) }

    def creator
     @creator ||= begin
        user_id = versions.where(event: "create").limit(1).pluck(:whodunnit).first
        User.find_by(id: user_id)
        end
    end
end
