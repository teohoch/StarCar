class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :car, foreign_key: true
      t.references :client, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :branch, foreign_key: true
      t.bigint :paid_amount
      t.integer :status

      t.timestamps
    end
  end
end
