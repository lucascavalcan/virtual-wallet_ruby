class WalletApi < Grape::API
    version 'v1', using: :path
    format :json
  
  
    resource :wallets do

      # POST /api/v1/wallets/deposit_withdraw
      desc 'Credit or debit money to the user\'s virtual wallet'
      params do
        requires :user_id, type: Integer
        requires :amount, type: Float
        requires :operation, type: String, values: %w[deposit withdraw]
      end
      post :deposit_withdraw do
        user = User.find(params[:user_id])
        wallet = user.wallet
  
        if wallet
          if wallet.perform_transaction(params[:operation], params[:amount])
            { message: "#{params[:operation].capitalize} successful." }
          else
            error!('Invalid operation or insufficient funds.', 400)
          end
        else
          error!('User not found.', 404)
        end
      end
  
      # GET /api/v1/wallets/balance
      desc 'Retrieve an user\'s virtual wallet current balance'
      params do
        requires :user_id, type: Integer
      end
      get :balance do
        user = User.find(params[:user_id])
        wallet = user.wallet
  
        if wallet
          { balance: wallet.amount }
        else
          error!('User not found.', 404)
        end
      end
  
      # GET /api/v1/wallets/entries
      desc 'Retrieve an user\'s virtual wallet entries in a period of time'
      params do
        requires :user_id, type: Integer
        requires :start_date, type: Date
        requires :end_date, type: Date
      end
      get :entries do
        user = User.find(params[:user_id])
        wallet = user.wallet.extracts

        wallet = if wallet.present?
          formatted_start_date = params[:start_date].beginning_of_day
          formatted_end_date = params[:end_date].end_of_day

          wallet = wallet.where("created_at BETWEEN ? AND ?", formatted_start_date, formatted_end_date).order(created_at: :asc)
        else
          error!('User not found.', 404)
        end

        wallet
      end

    end
  end
  