class PopulateEmployees < ActiveRecord::Migration[5.1]
  def up
    user = Employee.create!(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      name: 'test',
      surname: 'tested',
      rut: '17995652-7',
      address: 'la luna',
      phone: 993_830_775
    )
    user.add_role :administrator
    Employee.create!(
      email: 'cfernandez@caefautomotriz.cl',
      password: 'password',
      password_confirmation: 'password',
      name: 'Cony',
      surname: 'Fernández Reumante',
      rut: '4.688.685-2',
      address: 'la luna',
      phone: 942_485_182
    )
    Employee.create!(
      email: 'fadam@caefautomotriz.cl',
      password: 'password',
      password_confirmation: 'password',
      name: 'Fernando',
      surname: 'Adam Lobos',
      rut: '7886348-k',
      address: 'la luna',
      phone: 958_308_252
    )
  end

  def down
    Employee.where(email: 'admin@example.com').destroy_all
  end
end
