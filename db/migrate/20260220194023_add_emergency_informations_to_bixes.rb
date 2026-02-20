class AddEmergencyInformationsToBixes < ActiveRecord::Migration[7.0]
  def change
    add_column :bixes, :emergency_contacts, :string
    add_column :bixes, :sensitivities, :string
  end
end
