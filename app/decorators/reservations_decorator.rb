class ReservationsDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[car client status created_at paid_amount]
  end

end
