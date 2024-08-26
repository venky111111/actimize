class BaseAppFeatureSerializer < ActiveModel::Serializer
 attributes :id, :name, :base_app_id, :base_app_sub_features

  has_many :base_app_sub_features
  def base_app_sub_features
    object.base_app_sub_features.all
  end
end
 
