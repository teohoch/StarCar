class QuotesDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[car quote_price  client created_at]
  end

  def pretty_show
    super(title: h.t('quote.show.table_title'))
  end
end
