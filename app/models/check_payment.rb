class CheckPayment < ApplicationRecord
  belongs_to :sale

  def folio
    ("%s%03d%04d" % [(self.created_at.year-2000), self.sale_id, self.id]).to_i
  end
end
