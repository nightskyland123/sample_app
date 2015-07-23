require "rails_helper"

RSpec.describe Micropost, type: :model do
  
  let(:attr) do
    {user_id: 2, content: "test micropost"}
  end
  
  it "should create a new instance given valid attributes" do
    Micropost.create! attr
  end
  
  it "should reject when no user owning the micropost" do
    no_user_micropost = Micropost.new attr.merge user_id: ''
    expect(no_user_micropost).to be_invalid
  end
  
  it "should reject when content of the micropost too long" do
    too_long_micropost = "a" * 141
    invalid_micropost = Micropost.new attr.merge content: too_long_micropost
    expect(invalid_micropost).to be_invalid
  end
  
  it "should reject when content of the micropost is not exist" do
    invalid_micropost = Micropost.new attr.merge content: ''
    expect(invalid_micropost).to be_invalid
  end
  
end