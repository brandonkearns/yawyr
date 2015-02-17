class Shelf < ActiveRecord::Base
  belongs_to :user
  has_many :books

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }

end
