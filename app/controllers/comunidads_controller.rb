class ComunidadsController < ApplicationController
  before_action :set_comunidad, only: %i[ show edit update destroy ]

  # GET /comunidads or /comunidads.json
  def index
    @comunidads = Comunidad.all
  end

  # GET /comunidads/1 or /comunidads/1.json
  def show
  end

  # GET /comunidads/new
  def new
    @comunidad = Comunidad.new
  end

  # GET /comunidads/1/edit
  def edit
  end

  # POST /comunidads or /comunidads.json
  def create
    @comunidad = Comunidad.new(comunidad_params)

    respond_to do |format|
      if @comunidad.save
        format.html { redirect_to @comunidad, notice: "Comunidad was successfully created." }
        format.json { render :show, status: :created, location: @comunidad }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comunidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comunidads/1 or /comunidads/1.json
  def update
    respond_to do |format|
      if @comunidad.update(comunidad_params)
        format.html { redirect_to @comunidad, notice: "Comunidad was successfully updated." }
        format.json { render :show, status: :ok, location: @comunidad }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comunidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comunidads/1 or /comunidads/1.json
  def destroy
    @comunidad.destroy
    respond_to do |format|
      format.html { redirect_to comunidads_url, notice: "Comunidad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comunidad
      @comunidad = Comunidad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comunidad_params
      params.require(:comunidad).permit(:nombre)
    end
end
