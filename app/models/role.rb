# Model roles
# name             string

class Role < ApplicationRecord
    #
    ## RELATIONS
    #
    has_many :users

    #
    ## VALIDATIONS
    #
    validates :name, presence: true, uniqueness: true
end
