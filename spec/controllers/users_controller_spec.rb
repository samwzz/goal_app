require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "renders index" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "render new form" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of user email and password" do
        post :create, user: { username: 'user', password: "" }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, user: { username: 'user', password: 'haha' }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to user show" do
        post :create, user: { username: 'user', password: 'password' }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      post :create, user: { username: 'user', password: 'password' }

      get :show, id: User.last.id
      expect(response).to render_template(:show)
    end
  end

end
