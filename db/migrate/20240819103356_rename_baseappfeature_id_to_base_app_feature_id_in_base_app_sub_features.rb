class RenameBaseappfeatureIdToBaseAppFeatureIdInBaseAppSubFeatures < ActiveRecord::Migration[6.1]
  def change
        rename_column :base_app_sub_features, :baseappfeature_id, :base_app_feature_id
  end
end
