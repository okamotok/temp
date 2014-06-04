require 'spec_helper'

describe "Movie" do 
  it "It should be valid" do
    movie = Movie.new
    movie.should == movie
  end	
end