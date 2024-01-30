class Deposit < ApplicationRecord
  belongs_to :client
  attribute :valor, :decimal, precision: 8, scale: 2
end
