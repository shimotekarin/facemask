class AddSkintypeToMasks < ActiveRecord::Migration[7.2]
  def change
    add_column :masks, :skintype, :string
  end
end
