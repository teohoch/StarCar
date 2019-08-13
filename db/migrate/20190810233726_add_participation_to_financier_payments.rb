class AddParticipationToFinancierPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :financier_payments, :participation, :string
  end
end
