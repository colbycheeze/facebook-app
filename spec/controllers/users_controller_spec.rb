require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    # @posts = [ FactoryGirl.create(:post, :user => @user) ]
  end

  describe 'GET #index' do
    it "populates a list of users" do
      get :index
      expect(assigns(:users)).to eq([@user])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested user to @user" do
      get :show, id: @user
      expect(assigns(:user)).to eq(@user)
    end

    # it "assigns the users posts to @posts" do
    #   get :show, id: @user
    #   expect(assigns(:posts)).to eq(posts)
    # end

    it "renders the :show template" do
      get :show, id: FactoryGirl.create(:user)
      expect(response).to render_template :show
    end
  end

end
