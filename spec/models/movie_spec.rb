require 'spec_helper'

describe Movie do
  before { @movie = FactoryGirl.create(:movie) }
  subject { @movie }

  it {should respond_to(:title) }
  it {should respond_to(:director) }
end
