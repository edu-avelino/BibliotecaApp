json.extract! aluno, :id, :nome, :data_nasc, :email, :created_at, :updated_at
json.url aluno_url(aluno, format: :json)
