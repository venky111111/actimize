class UserAppFeatureSerializer < ActiveModel::Serializer
   attributes :id, :name, :user_app_id, :user_app_sub_features

    has_many :user_app_sub_features
    def user_app_sub_features
    object.user_app_sub_features.all
  end
end


