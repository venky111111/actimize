class UserApp < ApplicationRecord
	has_many :user_app_features, dependent: :destroy
	serialize :app_platform, Array
	has_many :user_app_documents, dependent: :destroy

end
