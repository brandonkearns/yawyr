class Book < ActiveRecord::Base
  belongs_to :shelf
  belongs_to :user

  validates :title, presence: true

  def self.search(query)
    term = query ? query.split.join("+") : "1984"
    results = HTTParty.get "https://www.googleapis.com/books/v1/volumes?q=#{term}&key=AIzaSyAGU5ZaUS5jtOHW761FF38i9pJNmZS3NNA"
  end

end
