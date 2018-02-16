class Car < ApplicationRecord
  belongs_to :brand
  belongs_to :branch
  belongs_to :fuel
  belongs_to :transmission
  has_many :repairs
  accepts_nested_attributes_for :repairs

  scope :in_repairs, -> {where(:state => 2)}
  scope :available, -> {where(:state => 1)}
  def status
    I18n.t("support.car_states.a#{state}")
  end



end
