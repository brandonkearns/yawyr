require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book)  { Book.new(title: "Native Son", author: "Richard Wright", thumbnail: "native_son.jpg", page_count: 450, pages_read: 200) }

  subject { book }

  it { should respond_to(:title) }
  it { should respond_to(:author) }
  it { should respond_to(:thumbnail) }
  it { should respond_to(:page_count) }
  it { should respond_to(:pages_read) }

  it { should be_valid }

  describe 'validations' do
    describe 'title' do
      context 'not present' do
      end
    end

    describe 'author' do
      context 'not present' do
      end
    end

    describe 'thumbnail' do
      context 'not present' do
      end
    end

    describe 'page count' do
      context 'not present' do
      end
    end

    describe 'pages read' do
      context 'not present' do
      end
    end

  end
end
