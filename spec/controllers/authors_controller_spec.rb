require "rails_helper"

RSpec.describe AuthorsController, type: :controller do
	describe "GET #index" do

    	it "responds successfully with an HTTP 200 status code" do
     		 get :index
      		expect(response).to be_success
      		expect(response).to have_http_status(200)
    	end
	
		it "loads all of the authors into @authors" do
      		auth1, auth2 = Fabricate(:author), Fabricate(:author)
      		get :index

      		expect(assigns(:authors)).to match_array([auth1, auth2])
    	end

		it "renders the index template" do
      			get :index
      			expect(response).to render_template("index")
    	end
	end
end

