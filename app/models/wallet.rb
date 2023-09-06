class Wallet < ApplicationRecord
  belongs_to :user
  has_many :extracts, dependent: :destroy

  def perform_transaction(operation, value)
    case operation
    when 'withdraw'
      withdraw(value)
    when 'deposit'
      deposit(value)
    else
      false # Operação inválida
    end
  end

  def withdraw(value)
    return unless amount >= value && value > 0

    self.amount -= value
    save
    create_extract(value, 'withdraw')
    true
  end

  def deposit(value)
    return unless value > 0

    self.amount += value
    save
    create_extract(value, 'deposit')
    true
  end

  private

  def create_extract(value, type)
    extracts.create(value: value, transaction_type: type)
  end
end
