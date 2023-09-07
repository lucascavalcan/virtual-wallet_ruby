require 'rails_helper'

RSpec.describe Wallet, type: :model do
  let(:user) { User.new }
  let(:wallet) { Wallet.new(amount: 0.0, user_id: user.id) }

  describe 'valid attributes' do

    it 'has a amount equal to "0.0"' do
      expect(wallet.amount).to eq(0.0)
    end

    it 'has a valid user_id' do
      expect(wallet.user_id).to eq(user.id)
    end

  end
end
