class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[ show edit update destroy ]

  # GET /providers
  def index
    @providers = Provider.all.page params[:page]
  end

  # GET /providers/1
  def show
  end

  # GET /providers/new
  def new
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to provider_url(@provider), notice: "Provider was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to provider_url(@provider), notice: "Provider was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  def destroy
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url, notice: "Provider was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provider_params
      params.require(:provider).permit(:nit, :name, :contact_name, :contact_phone, :bank_id, :account_number)
    end
end
