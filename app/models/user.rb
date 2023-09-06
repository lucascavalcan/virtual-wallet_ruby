class User < ApplicationRecord
    has_one :wallet, dependent: :destroy
  
    def create_wallet_with_extracts
      transaction do
        create_wallet
        wallet.extracts.create
      end
    end
  end
  