class DepositsController < ApplicationController
  before_action :set_client

  def index
    @deposits = Deposit.all
  end

  def new
    @deposit = @client.deposits.build
  end

  def show
    @deposit = @client.deposits.find(params[:id])

    respond_to do |format|
      format.html # Para resposta HTML
      format.json { render json: @deposit } # Para resposta JSON
    end
    respond_to(&:html)
  end

  def create
    @deposit = @client.deposits.build(deposit_params)

    if @deposit.save
      redirect_to @client, notice: 'Depósito adicionado com sucesso.'
    else
      flash[:alert] = 'Erro ao salvar o depósito.'
      render :new
    end
  end

  def destroy
    @client = Client.find(params[:client_id])
    @deposit = @client.deposits.find(params[:id])
    @deposit.destroy
    redirect_to client_path(@client), notice: 'Depósito excluído com sucesso.'
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def deposit_params
    params.require(:deposit).permit(:valor)
  end
end
