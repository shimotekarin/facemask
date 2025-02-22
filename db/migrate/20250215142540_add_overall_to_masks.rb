class AddOverallToMasks < ActiveRecord::Migration[7.2]
  def change
    add_column :masks, :overall, :integer
  end
end
