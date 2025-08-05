class Purchase < ApplicationRecord
  include Filterable
  #
  ## RELATIONS
  #
  belongs_to :client
  belongs_to :product
end
