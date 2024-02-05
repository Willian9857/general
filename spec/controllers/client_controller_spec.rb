require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  describe "GET #index" do
    it "renderiza o template desejado" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "Identifica o cliente" do
      client = FactoryBot.create(:client)
      get :show, params: { id: client.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renderiza o template 'new'" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "cria um novo objeto e redireciona para a página de exibição" do
      post :create, params: { client: valid_params }

      expect(Client.count).to eq(1)
      expect(response).to redirect_to(assigns(:client))
    end

    context "com parâmetros inválidos" do
      it "renderiza novamente o template 'new'" do
        post :create, params: { client: invalid_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    let(:client) { FactoryBot.create(:client) }

    it "Atualiza o cliente corretamente" do
      new_attributes = { nome: "Novo Nome", email: "novo_email@example.com", endereco: "Novo Endereço" }

      put :update, params: { id: client.id, client: new_attributes }

      client.reload

      expect(client.nome).to eq("Novo Nome")
      expect(client.email).to eq("novo_email@example.com")
      expect(client.endereco).to eq("Novo Endereço")
    end

    context "com parâmetros inválidos" do
      it "Renderiza novamente o template 'edit'" do
        put :update, params: { id: client.id, client: invalid_params }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:client) { FactoryBot.create(:client) }

    it "Exclui o cliente e seus depósitos corretamente" do
      FactoryBot.create_list(:deposit, 3, client: client)

      expect { delete :destroy, params: { id: client.id } }.to change(Client, :count).by(-1)

      expect(client.deposits.count).to eq(0)

      expect(response).to redirect_to(clients_url)
      expect(flash[:notice]).to eq('Cliente excluído com sucesso.')
    end
  end

  describe "#dashboard" do
    it "atribui depósitos aos clientes e calcula os depósitos totais" do
      client1 = create(:client)
      client2 = create(:client)

      create(:deposit, client: client1, valor: 100)
      create(:deposit, client: client1, valor: 200)
      create(:deposit, client: client2, valor: 150)

      get :dashboard

      # Verifique se a variável de instância @clients contém todos os clientes
      expect(assigns(:clients)).to match_array([client1, client2])

      # Verifique se a variável de instância @total_deposits contém a soma correta
      expect(assigns(:total_deposits)).to eq(450)
    end
  end
end
