require 'rails_helper'

describe 'Authentication' do
  subject { page }

  describe 'sign in page' do
    before { visit signin_path }

    it { should have_title('Sign In') }
    it { should have_content('Sign In') }

    describe 'sign in process' do
      let(:submit) { 'Sign In' }
      let(:user) { User.create(name: "Brandon Kearns", email: "brandon.j.kearns@gmail.com", password: "foobar", password_confirmation: "foobar") }

      context 'valid information' do
        before { sign_in user}

        it { should have_title(user.name) }
      end

      context 'invalid information' do
        it 'does not sign in user' do
          
        end
      end
    end
  end
end