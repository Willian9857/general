require 'rails_helper'

RSpec.describe Client, type: :model do
  it "is not valid without a name" do
    client = Client.new(nome: nil)
    expect(client).to_not be_valid
  end

  it "is not valid without an email" do
    client = Client.new(email: nil)
    expect(client).to_not be_valid
  end

  it "is valid with valid attributes" do
    client = Client.new(nome: "John Doe", email: "john@example.com")
    expect(client).to be_valid
  end
end
