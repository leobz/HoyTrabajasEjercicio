class BanksController < ApplicationController
  before_action :set_bank, only: %i[ show edit update destroy ]

  # GET /banks
  def index
    @banks = Bank.all
  end

  # GET /banks/1
  def show
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

  # POST /banks
  def create
    @bank = Bank.new(bank_params)

    respond_to do |format|
      if @bank.save
        format.html { redirect_to bank_url(@bank), notice: "Bank was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banks/1
  def update
    respond_to do |format|
      if @bank.update(bank_params)
        format.html { redirect_to bank_url(@bank), notice: "Bank was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  def destroy
    @bank.destroy

    respond_to do |format|
      format.html { redirect_to banks_url, notice: "Bank was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_params
      params.require(:bank).permit(:name)
    end
end
