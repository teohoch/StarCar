class AddDefaultsToSales < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:sales, :final_price, from: nil, to: 0)
    change_column_default(:sales, :appraisal, from: nil, to: 0)
    change_column_default(:sales, :tax, from: nil, to: 0)
    change_column_default(:sales, :transfer_cost, from: nil, to: 0)
    change_column_default(:sales, :transfer_discount, from: nil, to: 0)
    change_column_default(:sales, :list_discount, from: nil, to: 0)
    change_column_default(:sales, :earnings, from: nil, to: 0)
    change_column_default(:sales, :pva, from: nil, to: 0)
    change_column_default(:sales, :list_price, from: nil, to: 0)
    change_column_default(:sales, :buy_price, from: nil, to: 0)
  end
end
