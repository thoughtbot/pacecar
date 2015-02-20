require 'rails_helper'

describe 'Search' do

  before do
    @abe    = create :user, first_name:  'Abe',    last_name: 'Anderson', description: 'Apple'
    @bob    = create :user, first_name:  'Bob',    last_name: 'Babson',   description: 'Banana'
    @cindy  = create :user, first_name:  'Cindy',  last_name: 'Clarkson', description: 'Cookie'
    @dave   = create :user, first_name:  'Dave'
    @ed     = create :user, last_name:   'Dave'
    @frank  = create :user, description: 'Dave'
    @george = create :user, first_name:  'Dave',   last_name: 'Dave',     description: 'Dave'

    @null   = create :user, first_name: nil,      last_name: nil,        description: nil
  end

  it 'Returns records which match the supplied term' do
    expect(User.first_name_equals('Abe')).to eq [@abe]
  end

  it 'Returns records which match any of the supplied terms' do
    expect(User.first_name_equals(['Abe', 'Bob'])).to eq [@abe, @bob]
  end

  it 'Returns records which match the supplied term when the term is nil' do
    expect(User.first_name_equals(nil)).to eq [@ed, @frank, @null]
  end

end
