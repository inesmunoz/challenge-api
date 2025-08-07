class Categorization < ApplicationRecord
  include Filterable
  #
  ## RELATIONS
  #
  belongs_to :product
  belongs_to :category
end
