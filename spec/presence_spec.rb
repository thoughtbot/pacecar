require 'rails_helper'

describe 'Presence' do

  before do
    @not_null = create :user, first_name: 'Fake'
    @null = create :user, first_name: nil
  end

  it 'Returns records for a _present column method' do
    expect(User.first_name_present).to eq [@not_null]
  end

  it 'Returns records for a _missing column method' do
    expect(User.first_name_missing).to eq [@null]
  end

  it 'Does not setup methods for boolean columns' do
    expect { User.admin_missing }.to raise_error(NoMethodError)
    expect { User.admin_present }.to raise_error(NoMethodError)
  end

end
