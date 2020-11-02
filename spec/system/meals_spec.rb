require 'rails_helper'


describe 'manage meal functions', type: :system do

  describe 'show the index, search meals' do

    context 'when user1 login' do
      before do
        # user1 login
        # @user1= FactoryBot.create(:user)
        # @meal1 = FactoryBot.create(:meal, user_id: @user1.id)
        titles= ["pizza", "pasta", "sushi", "banana cake", "sunny egg"]
        (1..5).each{|x|
          user= FactoryBot.create(:user, name: "user#{x}", email: "user#{x}@cook.com")
          FactoryBot.create(:meal, user_id: user.id, title: titles[x-1])
        }


        visit login_path
        fill_in 'email', with: "user1@cook.com"
        fill_in 'password', with: '12345678'
        click_button 'login'
      end

      it 'shows the meals created by user0' do
        expect(page).to have_content 'pizza'
      end
      it 'shows the meals created by user1' do
        expect(page).to have_content 'pasta'
      end
      it 'shows the meals created by user2' do
        expect(page).to have_content 'sushi'
      end
      it 'shows the meals created by user3' do
        expect(page).to have_content 'banana cake'
      end
      it 'shows the meals created by user4' do
        expect(page).to have_content 'sunny egg'
      end
    end
    context 'search specified meals' do
      before do

        titles= ["spicy pizza", "sweet pasta", "spicy sushi", "sweet banana cake", "sunny egg"]
        contents = ["tomato buffara", "egg spinaci", "riso tonno", "banana sugar", "egg sugar"]
        (1..5).each{|x|
          user= FactoryBot.create(:user, name: "user#{x}", email: "user#{x}@cook.com")
          FactoryBot.create(:meal, user_id: user.id, title: titles[x-1], content: contents[x-1])
        }
        visit login_path
        fill_in 'email', with: "user1@cook.com"
        fill_in 'password', with: '12345678'
        click_button 'login'

        visit search_meals_path
        fill_in 't_keyword', with: "Sweet"
        fill_in 'c_keyword', with: "sugAr"
        click_button 'send'
      end

      it 'has double match' do
        expect(page).to have_content 'Double matched'
      end

      it 'has sweet pasta' do
        expect(page).to have_content 'sweet pasta'
      end

      it 'has sunny egg' do
        expect(page).to have_content 'sunny egg'
      end

    end
  end
end
