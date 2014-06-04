require 'spec_helper'

describe "Listing similar movies" do
  subject { page }
  before(:all) do
    movies = [{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'},
        {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984'},
        {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989'},
          {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011'},
          {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'},
          {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001'},
          {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968'},
          {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004'},
          {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'},
          {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
     ]
   movies.each do |movie|
    Movie.create!(movie)
   end
  end

  describe "Details page for aladin" do
    before { visit '/movies/1' }
    it { should have_content('Details about Aladdin') }
  end

  describe "Details page has a link to similar movies" do
    before { visit '/movies/1' }
    it { should have_link('Find Movies With Same Director') }

    describe "link works correctly" do
      before { click_link('Find Movies With Same Director') }
      it { should have_content('Movies similar to Aladdin') }
    end

  end



end

