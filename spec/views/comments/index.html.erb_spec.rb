require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    assign(:comments, [
      Comment.create!(
        :content => "Content",
        :user_id => 1,
        :micropost_id => 2
      ),
      Comment.create!(
        :content => "Content",
        :user_id => 1,
        :micropost_id => 2
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
