class User < ApplicationRecord
  enum role: { admin: "admin", sales: "sales", employee: "employee" }

  belongs_to :employee
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
