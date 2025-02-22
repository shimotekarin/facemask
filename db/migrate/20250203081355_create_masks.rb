class CreateMasks < ActiveRecord::Migration[7.2]
  def change
    create_table :masks do |t|
      t.string :mask_name
      t.text :body

      t.timestamps
    end
  end
end
