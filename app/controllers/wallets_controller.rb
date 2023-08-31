class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[ show edit update destroy ]

  # GET /wallets or /wallets.json
  def index
    @wallets = Wallet.all
  end

  # GET /wallets/1 or /wallets/1.json
  def show
    @wallet = Wallet.find(params[:id])
    @extracts = @wallet.extracts
  end

  # GET /wallets/new
  def new
    @wallet = Wallet.new
  end

  # GET /wallets/1/edit
  def edit
  end

  # POST /wallets or /wallets.json
  def create
    @wallet = Wallet.new(wallet_params)

    respond_to do |format|
      if @wallet.save
        format.html { redirect_to wallet_url(@wallet), notice: "Wallet was successfully created." }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallets/1 or /wallets/1.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to wallet_url(@wallet), notice: "Wallet was successfully updated." }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/1 or /wallets/1.json
  def destroy
    @wallet.destroy

    respond_to do |format|
      format.html { redirect_to wallets_url, notice: "Wallet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

 # POST amount of wallet
def withdraw_or_deposit
    @wallet = Wallet.find(params[:id])
    value = params[:value].to_f

    case params[:operation]
    when 'withdraw'
      if @wallet.amount >= value
        @wallet.amount -= value
        @wallet.save
        create_extract(value, 'withdraw')
        redirect_to @wallet, notice: 'Withdrawal successful.'
      else
        redirect_to @wallet, notice: "Insufficient funds for withdrawal."
      end
    when 'deposit'
      if value > 0
        @wallet.amount += value
        @wallet.save
        create_extract(value, 'deposit')
        redirect_to @wallet, notice: 'Deposit successful.'
      else
        redirect_to @wallet, notice: "Invalid deposit amount."
      end
    end
end

private

def create_extract(value, type)
  @wallet.extracts.create(value: value, transaction_type: type)
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:amount, :user_id)
    end
end
