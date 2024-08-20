class UserAppFeature < ApplicationRecord
	 has_many :user_app_sub_features
  	belongs_to :user_app
end
