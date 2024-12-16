class CsvImportServiceAluno
    require 'csv'
  
    def call(file)
      opened_file = File.open(file)
      options = { headers: true, col_sep: ';' }
      CSV.foreach(opened_file, **options) do |row|
  
        # map the CSV columns to your database columns
        aluno_hash = {}
        aluno_hash[:nome] = row['nome']
        aluno_hash[:data_nasc] = row['data']
        aluno_hash[:email] = row['email']
  
        Aluno.find_or_create_by!(aluno_hash)
        # for performance, you could create a separate job to import each aluno
        # CsvImportJob.perform_later(aluno_hash)
      end
    end
  end