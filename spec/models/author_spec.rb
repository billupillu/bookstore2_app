require 'spec_helper'
require 'pry'

describe Author do
  it "first_name should be present" do
  	author = Fabricate.build(:author, first_name: nil)
  	expect(author).not_to be_valid
  	expect(author.errors[:first_name]).to include("can't be blank")
  end

   it "last_name should be present" do
  	author = Fabricate.build(:author, last_name: nil)
  	expect(author).not_to be_valid
  	expect(author.errors[:last_name]).to include("can't be blank")
  end

  describe "#full_name" do
  	it "returns full name" do
  		author = Fabricate(:author)
  		expect(author.full_name).to eq("#{:first_name} #{:last_name}")
  	end
  end	

end
