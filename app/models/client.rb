class Client < ApplicationRecord
  has_many :projects

  validates :title, presence: true

  def details
    [title, contact_person].join(" | ")
  end
end
