class PopulateBranches < ActiveRecord::Migration[5.1]
  def up
    employee = Employee.find_by_email('cfernandez@caefautomotriz.cl')
    Branch.create!(
      title: 'Viña del Mar',
      location: 'Avenida San Martín 800, Viña del Mar.',
      phone: 320_000_000,
      manager: employee
    )
    employee = Employee.find_by_email('fadam@caefautomotriz.cl')
    Branch.create!(
      title: 'Villa Alemana Principal',
      location: 'Av. Valparaíso 407, Villa Alemana.',
      phone: 320_000_000,
      manager: employee
    )
    Branch.create!(
      title: 'Villa Alemana Anexo',
      location: 'Av. Valparaíso 407, Villa Alemana.',
      phone: 320_000_000,
      manager: employee
    )
  end

  def down
    Branch.all.destroy_all
  end
end
