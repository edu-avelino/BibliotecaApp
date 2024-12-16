Rails.application.routes.draw do
  resources :emprestimos
  resources :livros do
    collection do
      post :import
    end
  end
  resources :alunos do
    collection do
      post :import
    end
  end
  root to: "home#index"
  get "export_csv", to: "home#export_csv", format: :csv
  get "export_csv_livros", to: "home#export_csv_livros", format: :csv
  get "downloadAluno", to: 'alunos#baixar_pdf'
  get "previewAluno", to: 'alunos#preview'
  get "downloadLivro", to: 'livros#baixar_pdf'
  get "previewLivro", to: 'livros#preview'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

