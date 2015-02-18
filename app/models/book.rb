class Book < ActiveRecord::Base
  belongs_to :shelf
  has_many :users, through: :shelves

  validates :pages_read, presence: true
end
