require 'spec_helper'

describe Movie do

  it "has a valid factory" do
    FactoryGirl.create(:movie).should be_valid
  end

  describe "should respond to director" do
    before { @movie = FactoryGirl.create(:movie) }
    subject { @movie }
    it {should respond_to(:director) }
  end

  describe "#directed_by method ->" do
    before :each do
      @aladdin = FactoryGirl.create(:movie, title: 'Aladdin', director: 'brown', rating: 'G', release_date: '25-Nov-1992')
      @terminator = FactoryGirl.create(:movie, title: 'The Terminator', director: 'cameroon', rating: 'R', release_date: '26-Oct-1984')
      @harry = FactoryGirl.create(:movie, title: 'Harry Met Sally',  director: 'brown', rating: 'R', release_date: '21-Jul-1989')
      @the_help = FactoryGirl.create(:movie, title: 'The Help', rating: 'PG-13', release_date: '10-Aug-2011')
    end

    context "matching directors ->" do
      it "should return movies with the specified director" do
        Movie.directed_by('brown').should include @aladdin, @harry
      end

      it "should not return movies with diffrent directors" do
        Movie.directed_by('brown').should_not include @terminator, @the_help
      end
    end #context "matching directors"

  end #describe "#directed_by method ->"

end #Movie
