require 'rails_helper'

RSpec.describe Extract, type: :model do
  let(:extract) { Extract.new(value:13, transaction_type:"deposit") }


  describe 'valid attributes' do
    it 'has a value equal to "13"' do
      expect(extract.value).to eq(13)
    end

    it 'has a transaction type equal to "deposit"' do
      expect(extract.transaction_type).to eq("deposit")
    end
  end


end
