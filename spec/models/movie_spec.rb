require 'spec_helper'

describe "Movie" do
  movie = Movie.new(title: "AVC")
  movie.should be_valid
end
