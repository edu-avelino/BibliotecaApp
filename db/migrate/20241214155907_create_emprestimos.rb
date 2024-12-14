class CreateEmprestimos < ActiveRecord::Migration[8.0]
  def change
    create_table :emprestimos, primary_key: [:id_aluno, :id_livro, :data_empr] do |t|
      t.bigint :id_aluno
      t.bigint :id_livro
      t.date :data_empr
      t.date :data_devo
      t.boolean :status #0 = em andamento, 1 = devolvido

      t.timestamps
    end
    add_foreign_key :emprestimos, :alunos, column: :id_aluno
    add_foreign_key :emprestimos, :livros, column: :id_livro
  end
end

class AddNotValidForeignKeyToEmprestimosAluno < ActiveRecord::Migration[8.0]
  def up
    add_concurrent_foreign_key :emprestimos, :alunos, column: :id_aluno, on_delete: :cascade, validate: false
  end

  def down
    remove_foreign_key_if_exists :emprestimos, column: :id_aluno
  end
end

class AddNotValidForeignKeyToEmprestimosLivro < ActiveRecord::Migration[8.0]
  def up
    add_concurrent_foreign_key :emprestimos, :livros, column: :id_livro, on_delete: :cascade, validate: false
  end

  def down
    remove_foreign_key_if_exists :emprestimos, column: :id_livro
  end
end