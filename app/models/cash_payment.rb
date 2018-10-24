class CashPayment < ApplicationRecord
  belongs_to :cash_payable, polymorphic: true, optional: true, optional: true
end
