require 'spec_helper'

describe "movies_controller ->" do

  subject { page }
  before do
    movies = [
      {:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'brown'},
      {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984', :director => 'cameroon'},
      {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989', :director => 'brown'},
      {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011', :director => nil},
      {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'},
      {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001'},
      {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968'},
      {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004'},
      {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'},
      {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
     ]
   movies.each do |movie|
    #Movie.create!(movie)
    FactoryGirl.create(:movie, movie)
   end
  end #before

  describe "Details page for aladin ->" do
    before do
      visit '/movies/1'
    end

    describe "it should have content 'details about aladdin' ->" do
     it { should have_content('Details about Aladdin') }
    end

    describe "it should have a link to movies with the same director ->" do
      it { should have_link('Find Movies With Same Director') }

      describe "the link href should be '/movies' ->" do
        it { should have_link('Find Movies With Same Director', href: "/movies/1/similar") }
      end
    end
  end # "Details page for aladin

  describe "Finding movies with the same director ->" do
    context "when the director exists ->" do
      before(:each) do
        visit '/movies/1'
        click_link('Find Movies With Same Director')
      end
      it { should have_content('Movies similar to Aladdin') }
      it { should have_content('When Harry Met Sally')}
      it "won't display movies from other directors" do
        expect(page).to_not have_content('The Terminator')
      end
    end

    context "when the director doesn't exist ->" do
      before(:each) do
        visit '/movies/4'
        click_link('Find Movies With Same Director')
      end

      it { should have_content('All Movies') }
      it { should have_content("'The Help' has no director info") }

    end

  end #describe "Finding movies with the same director ->"

  describe ""

end

