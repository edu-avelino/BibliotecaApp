class AddDefaultsToAlunos < ActiveRecord::Migration[8.0]
  def change
    change_column_default :alunos, :nome, "Nome não informado"
    change_column_default :alunos, :data_nasc, "Data não informada"
    change_column_default :alunos, :email, "Email não informado"
  end
end
