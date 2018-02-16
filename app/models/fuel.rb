class Fuel < ApplicationRecord
  has_many :cars

  def name
    I18n.t("support.fuel.#{super}", default: super)
  end
end
