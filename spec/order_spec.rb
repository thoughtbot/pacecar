require 'spec_helper'

describe 'Order' do

  before do
    @first = create :user, first_name: 'Abe'
    @last  = create :user, first_name: 'Zed'
  end

  it 'Returns the correct results for a by_ column method with no args' do
    expect(User.by_first_name).to eq [@first, @last]
  end

  it 'Returns the correct results for a by_ column method with asc args' do
    expect(User.by_first_name(:asc)).to eq [@first, @last]
  end

  it 'Returns the correct results for a by_ column method with desc args' do
    expect(User.by_first_name(:desc)).to eq [@last, @first]
  end

end
