require 'rails_helper'

RSpec.describe DepositsController, type: :controller do
  describe 'GET #index' do
    let(:client) { create(:client) }
    it 'atribui todos os depósitos do cliente à variável @deposits' do
      deposit1 = create(:deposit, client: client)
      deposit2 = create(:deposit, client: client)

      get :index, params: { client_id: client.id }

      expect(assigns(:deposits)).to match_array([deposit1, deposit2])
    end

    it 'renderiza a view index' do
      get :index, params: { client_id: client.id }

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    let(:valid_client_params) { valid_params }

    it 'atribui um novo depósito à variável @deposit associado ao cliente' do
      client = build(:client, valid_client_params)

      client.save

      get :new, params: { client_id: client.id }

      expect(assigns(:deposit).client).to eq(client)
    end

    it 'renderiza a view new' do
      client = build(:client, valid_client_params)

      client.save

      get :new, params: { client_id: client.id }

      expect(response).to render_template(:new)
    end

    context 'com parâmetros válidos' do
      it 'cria um novo depósito associado ao cliente' do
        client = create(:client, valid_params)

        valid_deposit_params = { valor: 100.00 }

        post :create, params: { client_id: client.id, deposit: valid_deposit_params }

        expect(Deposit.last).to have_attributes(valid_deposit_params)
        expect(Deposit.last.client).to eq(client)
      end

      it 'redireciona para a página do cliente com uma mensagem de sucesso' do
        client = create(:client, valid_params)

        valid_deposit_params = { valor: 100.00 }

        post :create, params: { client_id: client.id, deposit: valid_deposit_params }

        expect(response).to redirect_to(client_path(client))
        expect(flash[:notice]).to eq('Depósito adicionado com sucesso.')
      end
    end

    context 'com parâmetros inválidos' do
      it 'não salva o depósito no banco de dados' do
        client = create(:client, valid_params)

        invalid_deposit_params = { valor: nil }

        post :create, params: { client_id: client.id, deposit: invalid_deposit_params }

        expect(assigns(:deposit)).not_to be_persisted
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET #show' do
    let(:valid_client_params) { valid_params }

    it 'atribui o depósito correto à variável @deposit' do
      client = create(:client, valid_client_params)

      deposit = create(:deposit, client: client)

      get :show, params: { client_id: client.id, id: deposit.id }

      expect(assigns(:deposit)).to eq(deposit)
    end

    it 'renderiza a view show' do
      client = create(:client, valid_client_params)

      deposit = create(:deposit, client: client)

      get :show, params: { client_id: client.id, id: deposit.id }

      expect(response).to render_template(:show)
    end
  end

  describe 'DELETE #destroy' do
    let(:valid_client_params) { valid_params }

    it 'exclui o depósito associado ao cliente' do
      client = create(:client, valid_client_params)

      deposit = create(:deposit, client: client)

      delete :destroy, params: { client_id: client.id, id: deposit.id }

      expect { deposit.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'redireciona para a página do cliente com uma mensagem de sucesso' do
      client = create(:client, valid_client_params)

      deposit = create(:deposit, client: client)

      delete :destroy, params: { client_id: client.id, id: deposit.id }

      expect(response).to redirect_to(client_path(client))
      expect(flash[:notice]).to eq('Depósito excluído com sucesso.')
    end
  end
end
