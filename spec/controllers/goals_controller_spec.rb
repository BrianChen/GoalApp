require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe "GET #new" do
    it "renders a new template" do
      get :new, goal: {}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to the show page" do
        goal = FactoryGirl.create(:goal)
        post :create, goal: {title: goal.title, visible: goal.visible, user_id: 1}
        expect(response).to redirect_to(goal_url(goal))
      end
    end
    context "with invalid params" do
      it "renders new page" do
        post :create, goal: {title: "fdasf"}
        expect(response).to render_template("new")
      end
    end
  end

end
