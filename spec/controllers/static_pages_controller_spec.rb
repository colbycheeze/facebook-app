require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do


  context "when not signed in" do
    describe "GET home" do
      it "redirects to register" do
        get :home
        expect(response).to be_redirect

        expect(response).to redirect_to(new_user_registration_path)
      end
    end
  end

  context "if signed in" do
    login_user
    describe "GET :home" do
      it "returns http success" do
        get :home
        expect(response).to have_http_status(:success)
      end
    end
  end
end
