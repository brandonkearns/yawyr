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
end
