class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:update, :destroy]

  # GET /transactions
  def index
    @transactions = current_user.transactions
    render json: @transactions, status: :ok
  end

  # POST /transactions
  def create
    @transaction = current_user.transactions.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/:id
  def update
    if @transaction.update(transaction_params)
      render json: @transaction, status: :ok
    else
      render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/:id
  def destroy
    @transaction.destroy
    render json: { message: "Transação removida com sucesso." }, status: :ok
  end

  private

  def transaction_params
    params.require(:transaction).permit(:description, :amount, :date, :category_id)
  end

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Registro não encontrado ou não autorizado." }, status: :not_found
  end
end