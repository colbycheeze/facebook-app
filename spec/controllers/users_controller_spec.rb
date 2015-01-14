require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe 'GET #index' do
    it "populates a list of users" do
      user = FactoryGirl(:user)
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested user to @user" do
      user = Factory(:user)
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders the :show template" do
      get :show, id: FactoryGirl(:user)
      expect(response).to render_template :show
    end
  end

end
