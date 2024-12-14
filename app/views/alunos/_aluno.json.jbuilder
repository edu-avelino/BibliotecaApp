json.extract! aluno, :id, :nome, :Data_Nasc, :email, :created_at, :updated_at
json.url aluno_url(aluno, format: :json)
