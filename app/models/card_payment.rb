class CardPayment < ApplicationRecord
  belongs_to :card_payable, polymorphic: true, optional: true
end
