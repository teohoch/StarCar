class FinancierPayment < ApplicationRecord
  belongs_to :financier_payable, polymorphic: true, optional: true
  belongs_to :financier
end
