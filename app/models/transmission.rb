class Transmission < ApplicationRecord
  has_many :cars
  def name
    I18n.t("support.transmission.#{super}", default: super)
  end
end
