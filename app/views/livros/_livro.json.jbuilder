json.extract! livro, :id, :titulo, :autor, :ano_publ, :quantidade, :created_at, :updated_at
json.url livro_url(livro, format: :json)
