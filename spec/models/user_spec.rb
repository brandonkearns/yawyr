require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: "Brandon Kearns", email: "bigtym10@aol.com", password: 'foobar', password_confirmation: 'foobar') }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe 'validations' do
    describe 'name' do
      context 'not present' do
        before { user.name = nil }
        it { should_not be_valid }
      end

      context 'too short' do
        before { user.name = 'b' * 2 }
        it { should_not be_valid }
      end

      context 'too long' do
        before { user.name = 'b' * 255 }
        it { should_not be_valid }
      end
    end

    describe 'email' do
      context 'not present' do
        it 'is invalid' do
          user.email = ""
          expect(user).to_not be_valid
        end
      end

      context 'too long' do
        it 'is invalid' do
          user.email = 'b' * 255
        end
      end
    end
  end
end
