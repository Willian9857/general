FactoryBot.define do
  factory :client do
    nome { "Willian Mendes" }
    sequence(:email) { |n| "willianmendes#{n}@gmail.com" }
    endereco { "Rua Mirim" }
  end
end

FactoryBot.define do
  factory :deposit do
    valor { 12_345.67 }
    association :client, factory: :client
  end
end

def valid_params
  { nome: "Willian Mendes", email: "willianmendes@gmail.com", endereco: "Rua Mirim" }
end

def invalid_params
  { nome: nil, email: "invalid_email", endereco: "Invalid Address" }
end
