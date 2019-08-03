# frozen_string_literal: true

class AddDeletedAtToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :cash_payments, :deleted_at, :datetime
    add_index :cash_payments, :deleted_at

    add_column :card_payments, :deleted_at, :datetime
    add_index :card_payments, :deleted_at

    add_column :check_payments, :deleted_at, :datetime
    add_index :check_payments, :deleted_at

    add_column :financier_payments, :deleted_at, :datetime
    add_index :financier_payments, :deleted_at

    add_column :vehicle_payments, :deleted_at, :datetime
    add_index :vehicle_payments, :deleted_at

    add_column :transfer_payments, :deleted_at, :datetime
    add_index :transfer_payments, :deleted_at
  end
end
