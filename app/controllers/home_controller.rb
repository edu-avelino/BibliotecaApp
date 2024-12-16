require 'csv'

class HomeController < ApplicationController
  def index
    @alunos = Aluno.all
    @livros = Livro.all
    @emprestimos = Emprestimo.all
  end

  def export_csv
    @alunos = Aluno.all

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["id", "nome", "email"]

      @alunos.each do |aluno|
        csv << [aluno.id, aluno.nome, aluno.email]
      end
    end

    request.format = :csv

    respond_to do |format|
      format.csv { send_data csv_data, filename: "alunos-#{Date.today}.csv" }
    end
  end

  def export_csv_livros
    @livros = Livro.all

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["id", "titulo", "autor", "ano"] # Ajuste os campos conforme o modelo Livro

      @livros.each do |livro|
        csv << [livro.id, livro.titulo, livro.autor, livro.ano_publ]
      end
    end

    request.format = :csv

    respond_to do |format|
      format.csv { send_data csv_data, filename: "livros-#{Date.today}.csv" }
    end
  end

  def export_csv_emprestimos
    @emprestimos = Emprestimo.all

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["id_aluno", "id_livro", "data_empr", "status"] # Ajuste os campos conforme o modelo Emprestimo

      @emprestimos.each do |emprestimo|
        csv << [emprestimo.id_aluno, emprestimo.id_livro, emprestimo.data_empr, emprestimo.status]
      end
    end

    request.format = :csv

    respond_to do |format|
      format.csv { send_data csv_data, filename: "emprestimos-#{Date.today}.csv" }
    end
  end

end

