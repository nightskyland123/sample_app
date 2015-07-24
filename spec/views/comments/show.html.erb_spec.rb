require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :content => "Content",
      :user_id => 1,
      :micropost_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
