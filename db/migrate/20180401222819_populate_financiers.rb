class PopulateFinanciers < ActiveRecord::Migration[5.1]
  FINANCIERS = %w[TANNER SANTANDER\ CONSUMER EUROCAPITAL MUNDO\ CREDITOS BK\ SPA NUEVO\ CAPITAL BANCO\ FALABELLA].freeze
  def up
    FINANCIERS.each do |financier_name|
      Financier.create! name: financier_name
    end
  end
  def down
    Financier.where(name: FINANCIERS).destroy_all
  end
end
