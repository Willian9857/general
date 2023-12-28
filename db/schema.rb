ActiveRecord::Schema[7.0].define(version: 2023_12_18_192017) do
  create_table "clients", force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.decimal "preco"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
