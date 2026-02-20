class ConfirmacoesController < ApplicationController
  before_action :set_bixe, only: %i[create destroy]

  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASSWORD']

  # GET /bixes/confirmacoes
  def index
    @confirmed = Bixe.confirmed
    @non_confirmed = Bixe.non_confirmed
    @bixes_by_team = Bixe.confirmed.group_by(&:team)
  end

  # POST /bixes/confirmacoes
  def create
    Confirmacao.create(bixe_id: @bixe.id) if @bixe
    redirect_to bixe_path(@bixe), notice: "Bixe Nº #{@bixe.id} confirmado no time \"#{@bixe.team}\""
  rescue ActiveRecord::RecordNotFound => e
    redirect_to confirmacoes_path, alert: e.message
  end

  # DELETE /bixes/:id/confirmacoes
  def destroy
    @bixe.confirmacao.destroy
    redirect_to bixe_path(@bixe), notice: "Bixe Nº #{@bixe.id} desconfirmado"
  rescue ActiveRecord::RecordNotFound => e
    redirect_to confirmacoes_path, alert: e.message
  end

  private

  def set_bixe
    @bixe = Bixe.find(params[:id])
  end
end
