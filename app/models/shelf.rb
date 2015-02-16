class Shelf < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }

end
