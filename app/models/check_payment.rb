class CheckPayment < ApplicationRecord
  belongs_to :check_payable, polymorphic: true, optional: true

  def folio
    ("%s%03d%04d" % [(self.created_at.year-2000), self.sale_id, self.id]).to_i
  end
end
