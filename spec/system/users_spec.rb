require 'rails_helper'


describe 'manage user functions', type: :system do

  describe 'check the number of the meals' do
    before do

      titles= ["pizza", "pasta", "sushi", "banana cake", "sunny egg"]
      (1..5).each{|x|
        user= FactoryBot.create(:user, name: "user#{x}", email: "user#{x}@cook.com")
        FactoryBot.create(:meal, user_id: user.id, title: titles[x-1])
      }
      #let(:user) { User.new(params) }
      #let(:params) { { name: 'たろう', age: age } }

    end
    context "create a user and a meal -> count increases" do

      it 'checks the increased count' do

        expect(Meal.all.count).to eq 5
      end

    end
    context 'create a user and a meal -> delete the user' do
      before do
        #visit user_path, id: "/#{@user1.id}"
        #click_button 'delete'
        @user_x= User.find_by(name: "user1")
        @user_x.destroy
      end

      it 'checks the decreased count' do
        # expect(@user1).to be_nil
        expect(Meal.all.count).to eq 4
      end

    end
  end
end
require 'rails_helper'


describe 'manage user functions', type: :system do

  describe 'check the number of the meals' do
    before do

      titles= ["pizza", "pasta", "sushi", "banana cake", "sunny egg"]
      (1..5).each{|x|
        user= FactoryBot.create(:user, name: "user#{x}", email: "user#{x}@cook.com")
        FactoryBot.create(:meal, user_id: user.id, title: titles[x-1])
      }
      #let(:user) { User.new(params) }
      #let(:params) { { name: 'たろう', age: age } }

    end
    context "create a user and a meal -> count increases" do

      it 'checks the increased count' do

        expect(Meal.all.count).to eq 5
      end

    end
    context 'create a user and a meal -> delete the user' do
      before do
        #visit user_path, id: "/#{@user1.id}"
        #click_button 'delete'
        @user_x= User.find_by(name: "user1")
        @user_x.destroy
      end

      it 'checks the decreased count' do
        # expect(@user1).to be_nil
        expect(Meal.all.count).to eq 4
      end

    end
  end
end
