class AddDueDateToCheckPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :check_payments, :due_date, :date
  end
end
