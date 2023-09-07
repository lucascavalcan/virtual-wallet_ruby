require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(user_name:"teste", email:"teste@gmail.com") }

  describe 'valid attributes' do
    it 'has a name "teste" ' do
      expect(user.user_name).to eq("teste")
    end

    it 'has a email "teste@gmail.com"' do
      expect(user.email).to eq("teste@gmail.com")
    end
  end

end
