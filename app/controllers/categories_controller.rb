class CategoriesController < ApplicationController
  before_action :authenticate_user!
  # Executa o filtro para buscar a categoria específica antes das ações de escrita
  before_action :set_category, only: [:update, :destroy]

  # GET /categories
  def index
    @categories = current_user.categories
    render json: @categories, status: :ok
  end

  # POST /categories
  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/:id
  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  def destroy
    @category.destroy
    render json: { message: "Categoria removida com sucesso." }, status: :ok
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  # Garante a segurança: busca a categoria exclusivamente dentro do escopo do usuário logado
  def set_category
    @category = current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Registro não encontrado ou não autorizado." }, status: :not_found
  end
end