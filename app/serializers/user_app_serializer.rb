class UserAppSerializer < ActiveModel::Serializer
  attributes :id, :application_name, :logo, :theme_color, :app_platform, :design, :basic_build,
             :full_build, :note, :budget, :payment_way, :support, :cloud, :market_place, :step, 
             :coupon_code, :base_app, :user_name, :user_role, :user_email, :user_phone, 
             :description, :features_count, :status

  has_many :user_app_features
  has_many :user_app_documents 

  def features_count
    object.user_app_features.size
  end
end
