require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book1) { FactoryGirl.create(:book) }
  let(:book2) { FactoryGirl.create(:book) }

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
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }

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
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }
    let(:shelf) { FactoryGirl.create(:shelf, user_id: user.id) }
    let(:edited_book) { FactoryGirl.create(:book, shelf_id: shelf.id) }

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
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }
    let(:shelf) { FactoryGirl.create(:shelf, user_id: user.id) }

    context 'valid attributes' do
      it 'creates new book' do
        expect{post :create, book: FactoryGirl.attributes_for(:book, shelf_id: shelf.id)}.to change(Book, :count).by(1)
      end

      it 'redirects to books#index' do
        post :create, book: FactoryGirl.attributes_for(:book, shelf_id: shelf.id)
        expect(response).to redirect_to(books_path)
      end
    end

    # context 'invalid attributes' do
    #   let(:invalid_attributes) { { title: "" } }

    #   it 'does not create a new book' do
    #     expect{post :create, book: invalid_attributes}.to_not change(Book, :count)
    #   end

    #   it 're-renders new' do
    #     post :create, book: invalid_attributes
    #     expect(response).to render_template(:new)
    #   end
    # end
  end

  describe 'PATCH #update' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }
    let(:shelf) { FactoryGirl.create(:shelf, user_id: user.id) }
    let(:edited_book) { FactoryGirl.create(:book, pages_read: 300, shelf_id: shelf.id) }

    context 'valid attributes' do
      it 'updates book' do
        patch :update, id: edited_book.id, book: { pages_read: 400 }
        edited_book.reload
        expect(edited_book.pages_read).to eq(400)
      end

      it 'redirects to books#show' do
        patch :update, id: edited_book.id, book: { pages_read: 400 }
        expect(response).to redirect_to(book_path(edited_book.id))
      end
    end

    context 'invalid attributes' do
      it 'does not update book' do
        patch :update, id: edited_book.id, book: { pages_read: nil }
        edited_book.reload
        expect(edited_book.pages_read).to eq(300)
      end

      it 're-renders edit' do
        patch :update, id: edited_book.id, book: { pages_read: nil }
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }
    let(:shelf) { FactoryGirl.create(:shelf, user_id: user.id) }
    it 'deletes selected book' do
      removed_book = FactoryGirl.create(:book, shelf_id: shelf.id)
      expect{delete :destroy, id: removed_book.id}.to change(Book, :count).by(-1)
    end

    it 'redirects to index' do
      removed_book = FactoryGirl.create(:book, shelf_id: shelf.id)
      delete :destroy, id: removed_book.id
      expect(response).to redirect_to(books_path)
    end
  end
end
