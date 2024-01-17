class DepositsController < ApplicationController
  before_action :set_client

  def new
    @deposit = @client.deposits.new
  end

  def show
    @client = Client.find(params[:client_id])
    @deposit = @client.deposits.find(params[:id])
  end

  def create
    @deposit = @client.deposits.new(deposit_params)

    if @deposit.save
      redirect_to @client, notice: 'Depósito adicionado com sucesso.'
    else
      render :new
    end
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def deposit_params
    params.require(:deposit).permit(:valor)
  end
end
