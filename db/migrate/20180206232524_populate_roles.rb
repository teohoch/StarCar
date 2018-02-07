class PopulateRoles < ActiveRecord::Migration[5.1]
  ROLES = ['administrator', 'employee', 'secretary']
  def up
    ROLES.each do |role_name|
      Role.create! name: role_name
    end
  end
  def down
    Role.where(name: ROLES).destroy_all
  end

end