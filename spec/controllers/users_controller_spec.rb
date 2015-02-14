require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    it 'renders new' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new User' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      let(:valid_attributes) { { name: "Brandon Kearns", email: "brandon@kearns.com", password: "foobar", password_confirmation: "foobar" } }

      it 'creates new user' do
        expect{post :create, user: valid_attributes}.to change(User, :count).by(1)
      end

      it 'redirects to users#show' do
        post :create, user: valid_attributes
        expect(response).to redirect_to(user_path(User.last.id))
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { name: '' } }

      it 'does not create new user' do
        expect{post :create, user: invalid_attributes}.to_not change(User, :count)
      end

      it 're-renders new' do
        post :create, user: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: "Brandon Kearns", email: "brandon.j.kearns@gmail.com", password: "foobar", password_confirmation: "foobar") }

    it 'renders show' do
      get :show, id: user.id
      expect(response).to render_template(:show)
    end

    it 'assigns correct user' do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #index' do
    let(:user1) { User.create(name: "Brandon Kearns", email: "brandon.j.kearns@gmail.com", password: "foobar", password_confirmation: "foobar") }
    let(:user2) { User.create(name: "Huey Newton", email: "fro@panthers.com", password: "frobar", password_confirmation: "frobar") }

    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'populates an array of users' do
      get :index
      expect(assigns(:users)).to eq([user1, user2])
    end
  end

  describe 'GET #edit' do
    let(:edited_user) { User.create(name: "Brandon Kearns", email: "brandon.j.kearns@gmail.com", password: "foobar", password_confirmation: "foobar") }

    it 'renders edit' do
      get :edit, id: edited_user.id
      expect(response).to render_template(:edit)
    end

    it 'assigns correct user' do
      get :edit, id: edited_user.id
      expect(assigns(:user)).to eq(edited_user)
    end
  end
end
