class TransferPayment < ApplicationRecord
  belongs_to :transfer_payable, polymorphic: true, optional: true
end
