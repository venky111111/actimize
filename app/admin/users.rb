ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :name, :email, :phone_number, :provider, :uid, :password_digest, :plaintext_password
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :phone_number, :provider, :uid, :password_digest]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
   index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone_number
    column :plaintext_password
    column :provider
    column :uid
   actions
  end
end
