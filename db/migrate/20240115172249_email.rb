# This is a migration for handling emails in the database.
class Email < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :email, :string
  end
end
