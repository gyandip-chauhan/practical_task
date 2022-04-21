class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :distances, dependent: :destroy

  validates :name, presence: true

  def generate_jwt_token
    JWT.encode({id: self.id, email: self.email, exp: Time.now.to_i + 10.minute.to_i}, Rails.application.secrets.secret_key_base)
  end
end
