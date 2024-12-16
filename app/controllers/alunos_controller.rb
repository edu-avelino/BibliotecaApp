class AlunosController < ApplicationController
  before_action :set_aluno, only: %i[ show edit update destroy ]

  # GET /alunos or /alunos.json
  def index
    @alunos = Aluno.order("id").page(params[:page]).per(4)
  end

  def baixar_pdf
    @aluno = Aluno.find(params[:id])
    pdf = Prawn::Document.new
    #pdf.text "Código de aluno: #{@aluno.id}"
    pdf.text "Nome: #{@aluno.nome}", size: 20
    pdf.text "Data de nascimento: #{@aluno.data_nasc}", size: 20
    pdf.text "Email: #{@aluno.email}", size: 20
    send_data(pdf.render,
    filename: "aluno_#{@aluno.nome}.pdf",
    type: 'application/pdf')
  end

  def preview
    @aluno = Aluno.find(params[:id])
    pdf = Prawn::Document.new
    pdf.text 'Isso é uma preview', size: 40
    #pdf.text "Código de aluno: #{@aluno.id}"
    pdf.text "Nome: #{@aluno.nome}", size: 20
    pdf.text "Data de nascimento: #{@aluno.data_nasc}", size: 20
    pdf.text "Email: #{@aluno.email}", size: 20
    send_data(pdf.render,
    filename: "aluno_#{@aluno.nome}.pdf",
    type: 'application/pdf',
    disposition: 'inline')
  end

  def import
    return redirect_to request.referer, notice: 'Nenhum arquivo adicionado' if params[:file].nil?
    return redirect_to request.referer, notice: 'Somente arquivos CSV são permitidos' unless params[:file].content_type == 'text/csv'

    CsvImportServiceAluno.new.call(params[:file])

    redirect_to request.referer, notice: 'Importação concluída!'
  end

  # GET /alunos/1 or /alunos/1.json
  def show
    @aluno = Aluno.find(params[:id])
  end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
  end

  # GET /alunos/1/edit
  def edit
  end

  # POST /alunos or /alunos.json
  def create
    @aluno = Aluno.new(aluno_params)

    respond_to do |format|
      if @aluno.save
        format.html { redirect_to @aluno, notice: "Aluno foi adicionado com sucesso." }
        format.json { render :show, status: :created, location: @aluno }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alunos/1 or /alunos/1.json
  def update
    respond_to do |format|
      if @aluno.update(aluno_params)
        format.html { redirect_to @aluno, notice: "Aluno foi editado com sucesso." }
        format.json { render :show, status: :ok, location: @aluno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1 or /alunos/1.json
  def destroy
    @aluno.destroy!

    respond_to do |format|
      format.html { redirect_to alunos_path, status: :see_other, notice: "Aluno foi apagado com sucesso" }
      format.json { head :no_content }
    end
  end

  def id
    @id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluno
      @aluno = Aluno.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def aluno_params
      params.expect(aluno: [ :nome, :data_nasc, :email ])
    end
end
