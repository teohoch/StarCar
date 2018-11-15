class CreateAcquisitions < ActiveRecord::Migration[5.1]
  def change
    create_table :acquisitions do |t|
      t.references :employee, foreign_key: true
      t.bigint :amount_paid
      t.references :car_provider, foreign_key: true

      t.timestamps
    end
  end
end
