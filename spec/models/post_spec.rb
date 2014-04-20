require 'spec_helper'

describe Post do 
  describe "validations" do 
    it "requires title" do 
      post = Post.new(title: nil)
      post.valid?
      post.errors[:title].should include("can't be blank")
    end

    it "requires body" do 
      post = Post.new(body: nil)
      post.valid?
      post.errors[:body].should include("can't be blank")      
    end
  end
end