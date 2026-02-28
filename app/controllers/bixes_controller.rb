class BixesController < ApplicationController
  before_action :set_bixe, only: %i[show edit update destroy]

  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASSWORD']

  # GET /bixes
  def index
    @bixes = Bixe.all
  end

  # GET /bixes/:id
  def show; end

  # GET /bixes/emails
  def emails
    @emails = Bixe.all.map(&:email).uniq
  end

  # GET /bixes/new
  def new
    @bixe = Bixe.new
  end

  # GET /bixes/1/edit
  def edit; end

  # POST /bixes
  def create
    @bixe = Bixe.new(bixe_params)

    respond_to do |format|
      if @bixe.save
        format.html { redirect_to @bixe, notice: 'bixe criado com sucesso!' }
        format.json { render :show, status: :created, location: @bixe }
      else
        format.html { flash[:error] = 'Preencha todos os dados!'; render :new }
        format.json { render json: @bixe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bixes/1
  def update
    respond_to do |format|
      if @bixe.update(bixe_params)
        format.html { redirect_to @bixe, notice: 'Bixe atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @bixe }
      else
        format.html { render :edit }
        format.json { render json: @bixe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bixes/1
  def destroy
    @bixe.destroy
    respond_to do |format|
      format.html { redirect_to bixes_url, notice: 'bixe apagado com sucesso' }
      format.json { head :no_content }
    end
  end

  private

  def set_bixe
    @bixe = Bixe.find(params[:id])
  end

  def bixe_params
    params[:bixe][:curso] = params[:bixe][:curso].to_i
    params.require(:bixe).permit(:nome, :email, :telefone, :curso, :emergency_contacts, :sensitivities)
  end
end
