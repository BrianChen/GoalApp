require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    it 'renders the new user page' do
      get :new, user: {}
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "renders new user page and shows errors" do
        post :create, user: {username:"Bob", password:""}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
        expect(flash.now[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to user show page" do
        post :create, user:{username:"Brian", password:"bob123"}
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

  describe "GET #show" do
    it "renders show page" do
      get :show, id:1
      expect(response).to render_template("show")
    end
  end
end
