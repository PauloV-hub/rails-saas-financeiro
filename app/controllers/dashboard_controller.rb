class DashboardController < ApplicationController
  before_action :authenticate_user!

  # GET /dashboard
  def index
    # Define o mês e o ano vindos da URL, ou assume o tempo presente como fallback
    mes = params[:month].present? ? params[:month].to_i : Time.current.month
    ano = params[:year].present? ? params[:year].to_i : Time.current.year

    # Cria o intervalo correspondente ao início e fim daquele mês específico
    data_inicio = Date.new(ano, mes, 1)
    data_fim = data_inicio.end_of_month

    # Filtra as transações do usuário estritamente dentro do intervalo de datas
    transacoes_do_mes = current_user.transactions.where(date: data_inicio..data_fim)

    # Executa os cálculos matemáticos performáticos apenas no bloco selecionado
    saldo_total = transacoes_do_mes.sum(:amount)
    total_receitas = transacoes_do_mes.where("amount > 0").sum(:amount)
    total_despesas = transacoes_do_mes.where("amount < 0").sum(:amount)

    render json: {
      periodo: {
        mes: mes,
        ano: ano,
        data_inicio: data_inicio,
        data_fim: data_fim
      },
      saldo_total: saldo_total,
      total_receitas: total_receitas,
      total_despesas: total_despesas
    }, status: :ok
  end
end