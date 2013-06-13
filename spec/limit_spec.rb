require 'spec_helper'

describe 'Limit' do

  before do
    create_list(:user, 15)
  end

  it 'Limits the results to the default value' do
    expect(User.count).to eq 15
    expect(User.limited.size).to eq 10
  end

  it 'Limits the results to the supplied value when sent args' do
    expect(User.count).to eq 15
    expect(User.limited(5).size).to eq 5
  end

  it 'Limits the results to the per_page value of the class' do
    User.expects(:per_page).returns 2
    expect(User.count).to eq 15
    expect(User.limited.size).to eq 2
  end

end
