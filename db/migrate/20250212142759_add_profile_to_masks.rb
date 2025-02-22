class AddProfileToMasks < ActiveRecord::Migration[7.2]
  def change
    add_column :masks, :profile, :string
  end
end
