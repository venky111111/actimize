class User < ApplicationRecord
	has_secure_password
  	validates :email, presence: true, uniqueness: true
  	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  	validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

      before_save :store_plaintext_password

    def store_plaintext_password
        self.plaintext_password = password if password.present? 
    end
end
