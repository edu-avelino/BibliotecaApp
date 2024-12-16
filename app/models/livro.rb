class Livro < ApplicationRecord
    has_many :emprestimos
    validates :ano_publ, presence: { message: "O ano de publicação é obrigatório." }
end
