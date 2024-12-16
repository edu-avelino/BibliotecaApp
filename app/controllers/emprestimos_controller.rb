class EmprestimosController < ApplicationController
  before_action :set_emprestimo, only: %i[ show edit update destroy ]

  # GET /emprestimos or /emprestimos.json
  def index
    @emprestimos = Emprestimo.order("id_aluno").page(params[:page]).per(3)
    @alunos = Aluno.all.index_by(&:id)
    @livros = Livro.all.index_by(&:id)
  end

  # GET /emprestimos/1 or /emprestimos/1.json
  def show
    @emprestimo = Emprestimo.find(params.expect(:id).split('_'))
    @alunos = Aluno.all.index_by(&:id)
    @livros = Livro.all.index_by(&:id)
  end

  # GET /emprestimos/new
  def new
    @emprestimo = Emprestimo.new
  end

  # GET /emprestimos/1/edit
  def edit
  end

  # POST /emprestimos or /emprestimos.json
  def create
    @emprestimo = Emprestimo.new(emprestimo_params)
    if @emprestimo.valid?

      respond_to do |format|
        if @emprestimo.save
          format.html { redirect_to @emprestimo, notice: "Emprestimo foi criado com sucesso." }
          format.json { render :show, status: :created, location: @emprestimo }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @emprestimo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /emprestimos/1 or /emprestimos/1.json
  def update
    respond_to do |format|
      if @emprestimo.update(emprestimo_params)
        format.html { redirect_to @emprestimo, notice: "Emprestimo foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @emprestimo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @emprestimo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emprestimos/1 or /emprestimos/1.json
  def destroy
    @emprestimo.destroy!

    respond_to do |format|
      format.html { redirect_to emprestimos_path, status: :see_other, notice: "Emprestimo foi apagado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emprestimo
      @emprestimo = Emprestimo.find(params.expect(:id).split('_'))
    end

    # Only allow a list of trusted parameters through.
    def emprestimo_params
      params.expect(emprestimo: [:id_aluno, :id_livro, :data_empr, :data_devo, :status])
    end
end
