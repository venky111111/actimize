class BaseAppSerializer < ActiveModel::Serializer
  attributes :id, :name, :logo,:theme_color, :app_platform,:design, :basic_build,  :full_build, :note, :budget, :payment_way, :support, :cloud, :market_place, :description
  has_many :base_app_features
  has_many :base_app_documents 
end
