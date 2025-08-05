class Product < ApplicationRecord
    include Filterable
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
    validates :price, numericality: { greater_than_or_equal_to: 0 }

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
end
