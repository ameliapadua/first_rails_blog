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

    it "redirects user to posts index page if signed in" do 
      session[:user_id] = 1
      get :index
      response.should redirect_to(posts_path)
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
      response.should redirect_to(posts_path)
      assigns(:user).should_not be_nil
      assigns(:user).should be_persisted
      assigns(:user).name.should == "Jonah Hex"
      session[:user_id].should == assigns(:user).id
    end

    it "requires name and email" do
      post :create, user: {name: nil, email: nil, password: "foo", password_confirmation: "foo"}
      response.should render_template(:index)
      assigns(:user).should_not be_nil
      assigns(:user).should_not be_persisted
      assigns(:user).should_not be_valid
    end
  end

  describe "sign_in" do 
    it "signs in a user" do 
      user = User.create(name: "Foo Bar", email: "foo@example.com", password: "password", password_confirmation: "password")

      post :sign_in, user: {
        email: "foo@example.com",
        password: "password"
      }

      session[:user_id].should == user.id
      response.should redirect_to(posts_path)
    end

    it "does not sign user in if password is incorrect" do 
      user = User.create(name: "Galaxy", email: "cosmos@cosmos.com", password: "galaxy", password_confirmation: "galaxy")

      post :sign_in, user: {
        email: "cosmos@cosmos.com",
        password: "password"
      }

      session[:user_id].should be_nil
      response.should render_template(:index)
    end

    it "does not sign user in if the user doesn't exist" do 
      post :sign_in, user: {
        email: "missing@example.com",
        passowrd: "password"
      }

      session[:user_id].should be_nil
      response.should render_template(:index)      
    end
  end

  describe "sign_out" do 
    it "signs out a user" do 
      session[:user_id] = 1

      post :sign_out

      session[:user_id].should be_nil
      response.should redirect_to(users_path)
    end
  end
end
