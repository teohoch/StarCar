class FinancierPayment < ApplicationRecord
  belongs_to :sale
  belongs_to :financier
end
