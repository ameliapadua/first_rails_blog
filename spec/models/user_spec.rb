require 'spec_helper'

describe User do
  describe "validations" do
    it "requires email" do
      user = User.new(email: nil)
      user.valid?
      user.errors[:email].should include("can't be blank")
    end

    it "requires name" do
      user = User.new(name: nil)
      user.valid?
      user.errors[:name].should include("can't be blank")
    end
  end
end