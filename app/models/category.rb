class Category < ApplicationRecord
    include Filterable
    has_paper_trail
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
