require 'rails_helper'

describe 'manage meal functions', type: :system do
  describe 'show the index' do
    before do
      # create user1
      #user1= FactoryBot.create(:user)
      @user1= FactoryBot.create(:user,name: 'aaa', email: 'user1@cook.com')
      # create a meal created by user1
      #FactoryBot.create(:meal, title: 'test pizza', user: user1)
      FactoryBot.create(:meal, user: @user1)
    end


    context 'when user1 login' do
      before do
        # user1 login
        visit login_path
        fill_in 'email', with: 'user1@cook.com'
        fill_in 'password', with: '1234'
        click_button 'login'
      end
      it 'show the meals created by user1' do
        # show the titles of the meals
        #expect(page).to have_content 'test title PIZZA'
        expect(@user1.name).to eq("aaa")
      end
    end
  end
end
