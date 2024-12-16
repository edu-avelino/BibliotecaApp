class LoginController < ApplicationController
    before_action :authenticate_usuario!, only: [:usuario]
    before_action :authenticate_admin!, only: [:admin]

    def home
    end
    
    def usuario
    end
  
    def admin
    end
end
