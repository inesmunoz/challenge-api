class Client < ApplicationRecord
    include Filterable
    #
    ## RELATIONS
    #
    has_many :purchases
    #
    ## VALIDATIONS
    #
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
