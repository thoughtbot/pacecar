require 'rails_helper'

describe 'Polymorph' do

  before do
    @owned_by_user = create :post, owner_type: 'User'
    @owned_by_mammal = create :post, owner_type: 'Mammal'
  end

  it 'Returns records on a _for column method with Class' do
    expect(Post.for_owner_type(User)).to eq [@owned_by_user]
  end

  it 'Returns records on a _for column method with String' do
    expect(Post.for_owner_type('User')).to eq [@owned_by_user]
  end

end
