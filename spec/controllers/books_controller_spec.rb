require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book1) { Book.create(title: "Brave New World", author: "Aldous Huxley", thumbnail: "brave.jpg", page_count: 500, pages_read: 250) }
  let(:book2) { Book.create(title: "Great Gatsby", author: "F Scott Fitzgerald", thumbnail: "old_sport.jpg", page_count: 450, pages_read: 225) }

  describe 'GET #index' do
    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'populates a shelf with books' do
      get :index
      expect(assigns(:books)).to eq([book1, book2])
    end
  end

  describe 'GET #show' do
    it 'renders show' do
      get :show, id: book1.id
      expect(response).to render_template(:show)
    end

    it 'assigns correct book' do
      get :show, id: book1.id
      expect(assigns(:book)).to eq(book1)
    end
  end

  describe 'GET #new' do
    it 'renders new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new book' do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe 'GET #edit' do
    let(:edited_book) { Book.create(title: "Great Gatsby", author: "F Scott Fitzgerald", thumbnail: "old_sport.jpg", page_count: 450, pages_read: 225) }

    it 'renders edit' do
      get :edit, id: edited_book.id
      expect(response).to render_template(:edit)
    end

    it 'assigns correct book' do
      get :edit, id: edited_book.id
      expect(assigns(:book)).to eq(edited_book)
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      let(:valid_attributes) { { title: "Great Gatsby", author: "F Scott Fitzgerald", thumbnail: "old_sport.jpg", page_count: 450, pages_read: 225, shelf_id: 3 } }

      it 'creates new book' do
        expect{post :create, book: valid_attributes}.to change(Book, :count).by(1)
      end

      it 'redirects to books#index' do
        post :create, book: valid_attributes
        expect(response).to redirect_to(books_path)
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { name: "" } }

      it 'does not create a new book' do
        expect{post :create, book: invalid_attributes}.to_not change(Book, :count)
      end

      it 're-renders new' do
        post :create, book: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:edited_book) { Book.create(title: "Great Gatsby", author: "F Scott Fitzgerald", thumbnail: "old_sport.jpg", page_count: 450, pages_read: 225) }

    context 'valid attributes' do
      it 'updates book' do
        patch :update, id: edited_book.id, book: { pages_read: 300 }
        edited_book.reload
        expect(edited_book.pages_read).to eq(300)
      end

      it 'redirects to books#show' do
        patch :update, id: edited_book.id, book: { pages_read: 300 }
        expect(response).to redirect_to(book_path(edited_book.id))
      end
    end

    context 'invalid attributes' do
      it 'does not update book' do
        patch :update, id: edited_book.id, book: { pages_read: nil }
        edited_book.reload
        expect(edited_book.pages_read).to eq(225)
      end

      it 're-renders edit' do
        patch :update, id: edited_book.id, book: { pages_read: nil }
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes selected book' do
      removed_book = Book.create(title: "Great Gatsby", author: "F Scott Fitzgerald", thumbnail: "old_sport.jpg", page_count: 450, pages_read: 225)
      expect{delete :destroy, id: removed_book.id}.to change(Book, :count).by(-1)
    end

    it 'redirects to index' do
      removed_book = Book.create(title: "Great Gatsby", author: "F Scott Fitzgerald", thumbnail: "old_sport.jpg", page_count: 450, pages_read: 225)
      delete :destroy, id: removed_book.id
      expect(response).to redirect_to(books_path)
    end
  end
end
