class WalletApi < Grape::API
    version 'v1', using: :path
    format :json
  
    # ...
  
    resource :wallets do
      desc 'Credit or debit money to the user\'s virtual wallet'
      params do
        requires :user_id, type: Integer
        requires :amount, type: Float
        requires :operation, type: String, values: %w[credit debit]
      end
      post :credit_debit do
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
  
      desc 'Retrieve an user\'s virtual wallet entries in a period of time'
      params do
        requires :user_id, type: Integer
        requires :start_date, type: Date
        requires :end_date, type: Date
      end
      get :entries do
        user = User.find(params[:user_id])
        wallet = user.wallet
  
        if wallet
          entries = wallet.extracts.where(transaction_date: params[:start_date]..params[:end_date]).order(transaction_date: :asc)
          { entries: entries }
        else
          error!('User not found.', 404)
        end
      end
    end
  end
  