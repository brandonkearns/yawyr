require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book1) { Book.create(title: "Brave New World", author: "Aldous Huxley", thumbnail: "brave.jpg", page_count: 500, pages_read: 250) }
  let(:book2) { Book.create(title: "Great Gatsby", author: "F Scott Fitzgerald", thumbnail: "old_sport.jpg", page_count: 450, pages_read: 225) }

  describe  
end
