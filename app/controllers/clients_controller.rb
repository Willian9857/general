class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all

    respond_to do |format|
      format.html
      format.json { render json: @clients }
    end
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Cliente atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Cliente excluído com sucesso.'
  end

  def dashboard
    @clients = Client.all
    
    @total_profit = @clients.sum(&:preco) || 0
  end

    private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:nome, :endereco, :preco, :email)
  end
end
