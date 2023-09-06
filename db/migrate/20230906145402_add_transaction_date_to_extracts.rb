class AddTransactionDateToExtracts < ActiveRecord::Migration[7.0]
  def change
    add_column :extracts, :transaction_date, :date
  end
end
