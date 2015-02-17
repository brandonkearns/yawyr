require 'rails_helper'

describe 'shelf pages' do
  subject { page }

  describe 'index' do
    let(:user) { FactoryGirl.create(:user) }
    Shelf.destroy_all
    let(:shelf1) { Shelf.create(name: "Fiction") }
    let(:shelf2) { Shelf.create(name: "Fantasy") }

    before { sign_in user }

    before { visit shelves_path }

    it { should have_title('My Shelves') }
    it { should have_selector('h1', text: 'My Shelves') }

    it 'lists each shelf' do
      Shelf.all.each do |shelf|
        expect(page).to have_selector('li', text: shelf.name)
      end
    end

    describe 'delete links' do
      let!(:shelf1) { Shelf.create(name: "Fiction") }
      let!(:shelf2) { Shelf.create(name: "Fantasy") }

      before { visit shelves_path }
      it { should have_link('delete', href: shelf_path(Shelf.first)) }

      describe 'after clicking delete' do
        before { click_link('delete', match: :first) }
        it { should_not have_content("Fiction") }
      end
    end 
  end

  describe 'show' do
    let(:user) { FactoryGirl.create(:user) }
    let(:shelf) { FactoryGirl.create(:shelf, user: user) }

    before { visit shelf_path(shelf.id) }

    it { should have_title(shelf.name) }
    it { should have_selector('h1', text: shelf.name) }
  end

  describe 'new shelf page' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit new_shelf_path
    end

    it { should have_title('Add Shelf') }
    it { should have_selector('h1', 'Add Shelf')}

    describe 'create shelf' do
      let(:submit) { 'Save' }

      context 'valid information' do
        before do
          fill_in 'Name',   with: "Fiction"
        end

        it 'creates shelf' do
          expect { click_button submit }.to change(Shelf, :count).by(1)
        end

        describe 'after saving' do
          before { click_button submit }

          it { should have_title('My Shelves') }
        end
      end

      context 'invalid information' do
        it 'does not create item' do
          expect { click_button submit }.not_to change(Shelf, :count)
        end

        describe 'after submission' do
          before { click_button submit }

          it { should have_title('Add Shelf') }
          it { should have_content('error') } 
        end
      end
    end
  end

  describe 'edit shelf page' do
    let(:user) { FactoryGirl.create(:user) }
    let(:edited_shelf) { FactoryGirl.create(:shelf, user: user) }

    before do
      sign_in user
      visit edit_shelf_path(edited_shelf.id)
    end

    it { should have_title('Edit Shelf') }
    it { should have_selector('h1', 'Edit Shelf') }

    describe 'update shelf' do
      let(:submit) { 'Save' }

      context 'valid information' do

        before do
          fill_in "Name", with: "Self-Help"
          click_button submit
        end

        describe 'after saving changes' do
          it { should have_title("Self-Help") }

          specify { expect(edited_shelf.reload.name).to eq("Self-Help") }
        end
      end

      context 'invalid information' do
        before do
          fill_in "Name", with: ""
          click_button submit
        end

        describe 'after submission' do
          it { should have_title("Edit Shelf") }
          it { should have_content("error") }
        end
      end
    end
  end
end