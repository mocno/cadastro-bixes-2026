class AddTeamtoConfirmacoes < ActiveRecord::Migration[7.0]
  def change
    add_column :confirmacoes, :team, :string
  end
end
