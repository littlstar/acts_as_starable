class ActsAsStarableMigration < ActiveRecord::Migration
  def change
    create_table :stars, force: true do |t|
      t.references :starer,   polymorphic: true, null: false
      t.references :starable, polymorphic: true, null: false
      t.timestamps
    end

    add_index :stars, ["starable_id", "starable_type"]
    add_index :stars, ["starer_id", "starer_type"]
  end
end
