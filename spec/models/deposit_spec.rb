require 'rails_helper'

RSpec.describe Deposit, type: :model do
  it 'cria um depósito válido' do
    deposit = create(:deposit)
    expect(deposit).to be_valid
  end

  it 'pertence a um cliente' do
    deposit = create(:deposit)
    expect(deposit.client).to be_a(Client)
  end

  it 'é inválido sem um valor' do
    deposit = build(:deposit, valor: nil)
    expect(deposit).to be_invalid
  end

  it 'tem a precisão e escala corretas para valor' do
    deposit = create(:deposit)
    expect(deposit.valor).to eq(12_345.67)
    expect(deposit.valor).to be_a(BigDecimal)
    expect(deposit.valor.to_s('F').split('.')[1].length).to be >= 2
  end

  it 'é persistido no banco de dados' do
    deposit = create(:deposit)
    expect(deposit).to be_persisted
  end

  it 'pode ser excluído' do
    deposit = create(:deposit)
    expect { deposit.destroy }.to change { Deposit.count }.by(-1)
  end
end
