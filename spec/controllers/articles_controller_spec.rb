require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
  	before do 
  		@john = User.create(email: "john@test.com", password: "password")
  	end

  	context "Owner is allowed to edit his articles" do 
  		it "renders the edit template" do 
  			login_user @john
  			article = Article.create(title: "First artile", body: 'body of first article', user: @john)

  			get :edit, id: article
  			expect(response).to render_template :edit
  		end
  	end

  	context "non-owner is not allowed to edit users articles" do 
  		it "redirects to the root path" do 
  			fred = User.create(email: "fred@test.com", password: "password")

  			login_user(fred)

  			article = Article.create(title: "first article", body: "body of first article", user: @john)

  			get :edit, id: article
  			expect(response). to redirect_to(root_path)
  			message = "You can only edit your own article."
  			expect(flash[:danger]).to eq message
  		end
  	end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
