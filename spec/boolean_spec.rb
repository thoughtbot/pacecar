require 'spec_helper'

describe 'Boolean' do

  before do
    @one = create :user, admin: true
    @two = create :user, admin: false
  end

  it 'Returns the matching result for a boolean columm method' do
    expect(User.admin).to eq [@one]
  end

  it 'Returns the matching result for a not_ boolean columm method' do
    expect(User.not_admin).to eq [@two]
  end

end
