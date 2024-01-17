class Deposit < ApplicationRecord
  belongs_to :client
  attribute :valor, :integer
end
