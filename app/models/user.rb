# Model users
# email             string
# password_digest   string


class User < ApplicationRecord
    has_secure_password
    #
    ## RELATIONS
    #
    belongs_to :role

    #
    ## VALIDATIONS
    #
    validates :email, presence: true, uniqueness: true

    # Helper to verify the role
    def has_role?(role_name)
        role&.name == role_name.to_s
    end
end
