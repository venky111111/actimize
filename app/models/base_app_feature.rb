class BaseAppFeature < ApplicationRecord
	 
      has_many :base_app_sub_features
  	belongs_to :base_app
end
