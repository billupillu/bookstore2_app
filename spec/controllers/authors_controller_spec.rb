require "rails_helper"

RSpec.describe AuthorsController, type: :controller do
	#================ INDEX ==============#

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

	#================ SHOW ==============#

	describe "GET #show" do 
		let(:author) { Fabricate(:author)}
		it "finds the author with the given Id and assign to @author" do
			get :show, id: author
			expect(assigns(:author)).to eq(author)
		end	

		it "renders the show template" do
			get :show, id: author
			expect(response).to render_template("show")
		end	
	end

	#================ NEW ==============#

	describe "GET #new" do
		it "assigns instance of new athor to @author variable" do
			get :new 
			expect(assigns(:author)).to be_instance_of(Author)
		end

		it "renders the new template" do
			get :new
			expect(response).to render_template("new")
		end	
	end

	#================ CREATE ==============#

	describe "POST #create" do
		context "successful save" do
			it "creates an author object" do
				post :create, author: Fabricate.attributes_for(:author)
				expect(Author.count).to eq(1)
			end
			it "redirects to show action" do
				post :create, author: Fabricate.attributes_for(:author)
				expect(response).to redirect_to author_path(Author.first)
			end
			it "sets successful flash message" do
				post :create, author: Fabricate.attributes_for(:author)
				expect(flash[:success]).to eq("Author has been created")
			end
		end

		context "unscuccessful save" do
			it "does not save an author object b'cauz invalid input" do
				post :create, author: Fabricate.attributes_for(:author,first_name: nil)
				expect(Author.count).to eq(0)
			end

			it "re renders the new template" do
				post :create, author: Fabricate.attributes_for(:author,first_name: nil)
				expect(response).to render_template("new")
			end

			it "sets unsuccessful flash message" do
				post :create, author: Fabricate.attributes_for(:author, first_name: nil)
				expect(flash[:danger]).to eq("Author has not been created")
			end
		end
	end

	#================ EDIT ==============#

	describe "GET #edit" do
		let(:author) {Fabricate(:author)}
		it "finds author with givenid and passes it to @author var" do
			get :edit, id: author
			expect(assigns(:author)).to eq(author)
		end

		it "renders the edit template" do
			get :edit, id: author
			expect(response).to render_template("edit")
		end
	end

	#================ UPDATE ==============#

	describe "PUT #update" do
		context "successful update" do
			let(:author) {Fabricate(:author)}
			it "updates an author object" do
				put :update, author: Fabricate.attributes_for(:author, first_name: "Andy"), id: author.id
				expect(Author.first.first_name).to eq("Andy")
			end
			it "redirects to show action" do
				put :update, author: Fabricate.attributes_for(:author, first_name: "Andy"), id: author.id
				expect(response).to redirect_to author_path(Author.first)
			end
			it "sets successful update flash message" do
				put :update, author: Fabricate.attributes_for(:author, first_name: "Andy"), id: author.id
				expect(flash[:success]).to eq("Author has been Updated")
			end
		end

		context "unscuccessful update" do
			let(:author) {Fabricate(:author, first_name: "Andy")}
			it "does not updates an author object" do
				put :update, author: Fabricate.attributes_for(:author, first_name: ""), id: author.id
				expect(Author.first.first_name).to eq("Andy")
			end
			it "renders the edit template" do
				put :update, author: Fabricate.attributes_for(:author, first_name: ""), id: author.id
				expect(response).to render_template("edit")
			end
			it "sets unsuccessful update flash message" do
				put :update, author: Fabricate.attributes_for(:author, first_name: ""), id: author.id
				expect(flash[:danger]).to eq("Author has not been Updated")
			end
		end
	end

	#================ DELETE ==============#

	describe "DELETE #destroy" do
		let(:author) {Fabricate(:author)}
		it "deletes the author with the given id" do
			delete :destroy, id: author
			expect(Author.count).to eq(0)
		end
		it "sets deletion success flash" do
			delete :destroy, id: author
			expect(flash[:success]).to eq("Author has been successfuly deleted")		 
		end
		it "redirects toindex action" do
			delete :destroy, id: author
			expect(response).to redirect_to authors_path
		end
	end
end

