# rubocop:disable Style/Documentation

class Email < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :email, :string, null: false, default: ''
  end
end
# rubocop:enable Style/Documentation
