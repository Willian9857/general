require "rails_helper"

RSpec.describe "Cliente" do
  context "Quando o cliente é cadastrado" do
    it "Testa a instância do cliente" do
      expect(Client.new).to be_present
    end
  end
end
