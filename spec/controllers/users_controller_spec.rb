require 'spec_helper'

describe UsersController do
  render_views

  describe "index" do
    it "renders the signup page" do
      get :index
      response.should be_success
    end

    it "provides a prototype user for sign up form" do
      get :index
      response.should be_success
      assigns(:user).should_not be_nil
    end
  end

  describe "create" do
    it "creates a new user account" do
      post :create, user: {
        email: "foo@example.com",
        password: "password",
        password_confirmation: "password",
        name: "Jonah Hex"
      }
      response.should be_success
      assigns(:user).should_not be_nil
      assigns(:user).should be_persisted
      assigns(:user).name.should == "Jonah Hex"
    end

    it "requires name and email" do
      post :create, user: {name: nil, email: nil, password: "foo", password_confirmation: "foo"}
      response.should be_success
      assigns(:user).should_not be_nil
      assigns(:user).should_not be_persisted
      assigns(:user).should_not be_valid
    end
  end
end
