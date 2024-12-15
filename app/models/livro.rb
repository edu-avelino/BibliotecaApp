class Livro < ApplicationRecord
    has_many :emprestimos
    has_one_attached :capa
end
