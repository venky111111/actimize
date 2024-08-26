class UserAppDocumentSerializer < ActiveModel::Serializer
  attributes :id, :user_app_file_name,:user_app_file_type, :user_app_file_data 
end
