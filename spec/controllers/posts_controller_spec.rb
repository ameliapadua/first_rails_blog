require 'spec_helper'

describe PostsController do

  describe "index" do 
    it "renders the posts index page" do 
      get :index
      response.should be_success
      assigns(:posts).should =~ Post.all
    end
  end

  describe "new" do 
    it "renders a post create form" do 
      get :new
      response.should be_success
      assigns(:post).should_not be_nil
    end
  end

  describe "create" do 
    it "creates a new post" do 
      session[:user_id] = 1
      post :create, post: {
        title: "Will Smith",
        body: "Great."
      }

      response.should redirect_to(posts_path)
      assigns(:post).should_not be_nil
      assigns(:post).should be_persisted
      assigns(:post).title.should == "Will Smith"
      assigns(:post).user_id.should == 1
    end

    it "requires valid parameters" do 
      post :create, post: {title: nil, body: nil}

      response.should render_template(:new)
      assigns(:post).should_not be_valid
      assigns(:post).should_not be_nil
      assigns(:post).should_not be_persisted
    end
  end
end
