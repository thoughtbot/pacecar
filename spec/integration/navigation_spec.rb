require 'rails_helper'

describe 'Navigation' do

  it 'should be a valid app' do
    expect(::Rails.application).to be_a(Pacecar::Application)
  end
end
