class AddIsDraftToMasks < ActiveRecord::Migration[7.2]
  def change
    add_column :masks, :is_draft, :boolean, default: true, null: false
  end
end