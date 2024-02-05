require 'rails_helper'

RSpec.describe Client, type: :model do
  it "não é válido sem um nome" do
    client = Client.new(nome: nil)
    expect(client).to_not be_valid
  end

  it "não é válido sem um e-mail" do
    client = Client.new(email: nil)
    expect(client).to_not be_valid
  end

  it "não é válido com formato inválido de e-mail" do
    client = Client.new(nome: "John Doe", email: "johnexample.com")
    expect(client).to_not be_valid
  end

  it "não é válido com email duplicado" do
    Client.create(nome: "Existing Client", email: "existing@example.com")
    client = Client.new(nome: "John Doe", email: "existing@example.com")
    expect(client).to_not be_valid
  end

  it "é válido com atributos válidos" do
    client = Client.new(nome: "John Doe", email: "john@example.com")
    expect(client).to be_valid
  end

  it 'é válido com parâmetros válidos' do
    valid_client = build(:client, valid_params)
    expect(valid_client).to be_valid
  end

  it 'não é válido com parâmetros inválidos' do
    invalid_client = build(:client, invalid_params)
    expect(invalid_client).not_to be_valid
  end
end
