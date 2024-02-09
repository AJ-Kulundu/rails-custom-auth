class User < ApplicationRecord
    has_secure_password

    normalizes :email, with: -> email {email.strip.downcase}

    validates :email, presence: true, uniqueness: true

    generates_token_for :password_reset, expires_in: 10.minutes do
        #last 10 characters of the password salt
        password_salt&.last(10)
    end
end
