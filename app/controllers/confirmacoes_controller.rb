class ConfirmacoesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASSWORD']

  def index
    @confirmed = Bixe.confirmed
    @non_confirmed = Bixe.non_confirmed
    @bixes_by_team = Bixe.confirmed.group_by(&:team)
  end

  def create
    bixe = Bixe.find(params[:id])
    Confirmacao.create(bixe_id: params[:id]) if Bixe.find(params[:id])
    redirect_to confirmacoes_path, notice: 'Bixe confirmado'
  rescue ActiveRecord::RecordNotFound => exception
    redirect_to confirmacoes_path, alert: exception.message
  end

  def sync_confirmations
    Confirmacao.find_each do |confirmacao|
      GoogleSheetsService.new.add_confirmation(confirmacao.bixe)
    end
  end

  def destroy
    confirmacao = Confirmacao.find(params[:id])

    confirmacao.destroy

    redirect_to confirmacoes_path, notice: 'Bixe desconfirmado'
  rescue ActiveRecord::RecordNotFound => exception
    redirect_to confirmacoes_path, alert: exception.message
  end
end
