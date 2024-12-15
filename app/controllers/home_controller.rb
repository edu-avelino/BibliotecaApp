require 'csv'

class HomeController < ApplicationController
  def index
    @alunos = Aluno.all
    @livros = Livro.all
  end

  def export_csv
    @alunos = Aluno.all

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["id", "nome", "idade"]

      @alunos.each do |aluno|
        csv << [aluno.id, aluno.nome, aluno.idade]
      end
    end

    respond_to do |format|
      format.csv { send_data csv_data, filename: "alunos-#{Date.today}.csv" }
    end
  end

  def export_csv_livros
    @livros = Livro.all

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["id", "titulo", "autor", "ano"] # Ajuste os campos conforme o modelo Livro

      @livros.each do |livro|
        csv << [livro.id, livro.titulo, livro.autor, livro.ano]
      end
    end

    respond_to do |format|
      format.csv { send_data csv_data, filename: "livros-#{Date.today}.csv" }
    end
  end
end

