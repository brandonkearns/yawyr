require 'rails_helper'

RSpec.describe ShelvesController, type: :controller do

  Shelf.destroy_all
  let(:shelf1) { Shelf.create(name: 'Fiction') }
  let(:shelf2) { Shelf.create(name: 'Fantasy') }

  describe 'GET #index' do
    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'populates an array of shelves' do
      get :index
      expect(assigns(:shelves)).to eq([shelf1, shelf2])
    end
  end

  describe 'GET #show' do
    it 'renders show' do
      get :show, id: shelf1.id
      expect(response).to render_template(:show)
    end

    it 'assigns correct shelf' do
      get :show, id: shelf1.id
      expect(assigns(:shelf)).to eq(shelf1)
    end
  end

  describe 'GET #new' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }

    it 'renders new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new Shelf' do
      get :new
      expect(assigns(:shelf)).to be_a_new(Shelf)
    end
  end

  describe 'GET #edit' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }

    let(:edited_shelf) { Shelf.create(name: "Self-Help", user_id: user.id) }

    it 'renders edit' do
      get :edit, id: edited_shelf.id
      expect(response).to render_template(:edit)
    end

    it 'assigns correct shelf' do
      get :edit, id: edited_shelf.id
      expect(assigns(:shelf)).to eq(edited_shelf)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }

    context 'valid attributes' do
      it 'creates a new shelf' do
        expect{post :create, shelf: FactoryGirl.attributes_for(:shelf, user_id: user.id)}.to change(Shelf, :count).by(1)
      end

      it 'redirects to shelves#index' do
        post :create, shelf: FactoryGirl.attributes_for(:shelf, user_id: user.id)
        expect(response).to redirect_to(shelves_path)
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { name: "F" } }

      it 'does not create new shelf' do
        expect{post :create, shelf: invalid_attributes}.to_not change(Shelf, :count)
      end

      it 're-renders new' do
        post :create, shelf: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }

    let(:edited_shelf) { FactoryGirl.create(:shelf, name: "Programming", user: user) }

    context 'valid attributes' do
      it 'updates shelf name' do
        patch :update, id: edited_shelf.id, shelf: { name: "Coding" }
        edited_shelf.reload
        expect(edited_shelf.name).to eq("Coding")
      end

      it 'redirects to items#show' do
        patch :update, id: edited_shelf.id, shelf: { name: "Coding" }
        expect(response).to redirect_to(shelf_path(edited_shelf.id))
      end
    end

    context 'invalid attributes' do
      it 'does not update shelf' do
        patch :update, id: edited_shelf.id, shelf: { name: "" }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }


    it 'deletes selected shelf' do
      unwanted_shelf = FactoryGirl.create(:shelf, user_id: user.id)
      expect{delete :destroy, id: unwanted_shelf.id}.to change(Shelf, :count).by(-1)
    end

    it 'redirects to index' do
      unwanted_shelf = FactoryGirl.create(:shelf, user_id: user.id)
      delete :destroy, id: unwanted_shelf.id
      expect(response).to redirect_to(shelves_path)
    end
  end
end
