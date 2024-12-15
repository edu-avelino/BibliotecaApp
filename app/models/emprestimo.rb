class Emprestimo < ApplicationRecord
    belongs_to :aluno, :optional => true
    belongs_to :livro, :optional => true
end
