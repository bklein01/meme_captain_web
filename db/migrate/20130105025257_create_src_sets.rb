class CreateSrcSets < ActiveRecord::Migration[4.2]
  def change
    create_table :src_sets do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :src_sets, :user_id
  end
end
