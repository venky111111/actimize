class UserAppFeature < ApplicationRecord
	 has_many :user_app_sub_features, dependent: :destroy
  	belongs_to :user_app
end
