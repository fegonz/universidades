class UniversidadsController < ApplicationController
  before_action :set_universidad, only: %i[ show edit update destroy ]

  # GET /universidads or /universidads.json
  def index
    @universidads = Universidad.all
    
  end

  # GET /universidads/1 or /universidads/1.json
  def show
  end

  # GET /universidads/new
  def new
    @universidad = Universidad.new
  end

  # GET /universidads/1/edit
  def edit
  end

  # POST /universidads or /universidads.json
  def create
    @universidad = Universidad.new(universidad_params)

    respond_to do |format|
      if @universidad.save
        format.html { redirect_to @universidad, notice: "Universidad was successfully created." }
        format.json { render :show, status: :created, location: @universidad }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @universidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /universidads/1 or /universidads/1.json
  def update
    respond_to do |format|
      if @universidad.update(universidad_params)
        format.html { redirect_to @universidad, notice: "Universidad was successfully updated." }
        format.json { render :show, status: :ok, location: @universidad }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @universidad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /universidads/1 or /universidads/1.json
  def destroy
    @universidad.destroy
    respond_to do |format|
      format.html { redirect_to universidads_url, notice: "Universidad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_universidad
      @universidad = Universidad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def universidad_params
      params.require(:universidad).permit(:nombre, :tipo, :url, :comunidad_id)
    end
end
