class CreateAlunos < ActiveRecord::Migration[8.0]
  def change
    create_table :alunos do |t|
      t.string :nome
      t.date :data_nasc
      t.string :email

      t.timestamps
    end
  end
end
