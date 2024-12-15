class Aluno < ApplicationRecord
  has_many :emprestimos

  validates :nome, presence: { message: "O nome é obrigatório." }

  before_save :set_default_values

  private

  def set_default_values
    self.data_nasc ||= "Data não informada"
    self.email ||= "Email não informado"
  end
end
