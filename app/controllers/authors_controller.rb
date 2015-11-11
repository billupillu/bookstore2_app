class AuthorsController < ApplicationController
	before_action :find_author, only: [:show, :destroy, :update, :edit]

	def index
		@authors = Author.all
	end

	def show
		#require 'pry';binding.pry
	end	

	def new 
		@author = Author.new
	end

	def create
		@author = Author.new(author_params)
		if @author.save
			flash[:success] = "Author has been created"
			redirect_to @author
		else
			flash[:danger] = "Author has not been created"
			render :new
		end	
	end

	def edit
	end

	def update
		if @author.update(author_params)
			flash[:success] = "Author has been Updated"
			redirect_to @author
		else
			flash[:danger] = "Author has not been Updated"
			render :edit
		end	
	end

	def destroy
		if @author.destroy
			flash[:success] = "Author has been successfuly deleted"
			redirect_to authors_path
		end	
	end

	private

	def find_author
		@author = Author.find(params[:id])
	end

	def author_params
		params.require(:author).permit(:first_name, :last_name)
	end
end
  