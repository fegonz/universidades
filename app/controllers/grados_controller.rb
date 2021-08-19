class GradosController < ApplicationController
  before_action :set_grado, only: %i[ show edit update destroy ]

  # GET /grados or /grados.json
  def index
    @grados = Grado.all
  end

  # GET /grados/1 or /grados/1.json
  def show
  end

  # GET /grados/new
  def new
    @grado = Grado.new
  end

  # GET /grados/1/edit
  def edit
  end

  # POST /grados or /grados.json
  def create
    @grado = Grado.new(grado_params)

    respond_to do |format|
      if @grado.save
        format.html { redirect_to @grado, notice: "Grado was successfully created." }
        format.json { render :show, status: :created, location: @grado }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grados/1 or /grados/1.json
  def update
    respond_to do |format|
      if @grado.update(grado_params)
        format.html { redirect_to @grado, notice: "Grado was successfully updated." }
        format.json { render :show, status: :ok, location: @grado }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grados/1 or /grados/1.json
  def destroy
    @grado.destroy
    respond_to do |format|
      format.html { redirect_to grados_url, notice: "Grado was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grado
      @grado = Grado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grado_params
      params.require(:grado).permit(:nombre, :url, :universidad_id)
    end
end
