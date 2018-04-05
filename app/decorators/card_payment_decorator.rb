class CardPaymentDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[amount card_number type bank]
  end

  def type
    I18n.t("support.card_types.c#{object.type}")
  end



end
