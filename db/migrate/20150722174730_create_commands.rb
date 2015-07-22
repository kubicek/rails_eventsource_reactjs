class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :uuid
      t.string :name
      t.text :data
      t.text :metadata
      t.string :requestor_type
      t.integer :requestor_id

      t.timestamps null: false
    end
  end
end
