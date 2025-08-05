class Category < ApplicationRecord
    include Filterable
    #
    ## RELATIONS
    #
    has_many :categorizations
    has_many :products, through: :categorizations
    #
    ## VALIDATIONS
    #
    validates :name, presence: true
end
