class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :uuid
      t.string :name
      t.text :data
      t.text :metadata
      t.string :eventable_type
      t.integer :eventable_id
      t.references :command, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
