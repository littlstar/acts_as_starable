ActiveRecord::Schema.define version: 0 do

  create_table :stars, force: true do |t|
    t.integer  "starable_id",   null: false
    t.string   "starable_type", null: false
    t.integer  "starer_id",     null: false
    t.string   "starer_type",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table :users, force: true do |t|
    t.column :name, :string
  end

  create_table :bands, force: true do |t|
    t.column :name, :string
  end

end
