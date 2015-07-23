require "rails_helper"

RSpec.describe MicropostsController, type: :controller do

  describe "GET #index" do
    let(:attr1) do
      { user_id: 2,
        content: "post from user 2 1" }
    end
    
    let(:attr2) do
      { user_id: 2,
        content: "post from user 2 2" }
    end
    
    let(:attr3) do
      { user_id: 3,
        content: "post from user 3" }
    end
    
    it "respond successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
    
    it "loads all of the micropost into @microposts" do
      post1, post2, post3 = Micropost.create!(attr1), Micropost.create!(attr2), Micropost.create!(attr3)
      get :index
      expect(assigns(:microposts)).to match_array([post1, post2, post3])
    end
  end

end