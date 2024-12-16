class CsvImportServiceLivro
    require 'csv'
  
    def call(file)
      opened_file = File.open(file)
      options = { headers: true, col_sep: ';' }
      CSV.foreach(opened_file, **options) do |row|
  
        # map the CSV columns to your database columns
        livro_hash = {}
        livro_hash[:titulo] = row['titulo']
        livro_hash[:autor] = row['autor']
        livro_hash[:ano_publ] = row['ano']
        livro_hash[:quantidade] = row['quantidade']
  
        Livro.find_or_create_by!(livro_hash)
        # for performance, you could create a separate job to import each livro
        # CsvImportJob.perform_later(livro_hash)
      end
    end
  end