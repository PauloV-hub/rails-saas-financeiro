class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: 'Cadastro realizado com sucesso.',
        user: resource
      }, status: :ok
    else
      render json: {
        message: "Não foi possível realizar o cadastro.",
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end