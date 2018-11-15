class QuotesDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[car quote_price  client created_at]
  end
end
