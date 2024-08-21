class BaseApp < ApplicationRecord
	has_many :base_app_features
	has_many :base_app_documents
end
