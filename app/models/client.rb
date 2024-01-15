class Client < ApplicationRecord
  attribute :nome, :string
  attribute :endereco, :string
  attribute :preco, :decimal
  attribute :email, :string

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Formato de e-mail inválido" }
end
