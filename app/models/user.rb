class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  # Um usuário possui muitas categorias e transações. 
  # Se o usuário for excluído, os dados associados também serão removidos.
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy

  before_create :generate_jti

  private

  def generate_jti
    self.jti = SecureRandom.uuid
  end
end