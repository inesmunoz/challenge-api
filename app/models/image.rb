class Image < ApplicationRecord
  #
  ## RELATIONS
  #
  belongs_to :imageable, polymorphic: true
  has_one_attached :file

  #
  ## VALIDATIONS
  #
  validates :file, presence: true
end
