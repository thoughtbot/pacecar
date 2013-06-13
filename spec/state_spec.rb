require 'spec_helper'

describe 'State' do

  before do
    @draft_post = create :post, publication_state: 'Draft'
    @final_post = create :post, publication_state: 'Final'
    @free_post = create :post, post_type: 'Free'
    @open_post = create :post, post_type: 'Open'

    @post = Post.new
    expect(Post::PUBLICATION_STATES).to_not be_nil
  end

  it 'Returns records for a column_state _state method' do
    expect(Post.publication_state_draft).to eq [@draft_post]
  end

  it 'Returns records for a column_not_state _state method' do
    expect(Post.publication_state_not_draft).to eq [@final_post]
  end

  it 'Returns records for a column_state _type method' do
    expect(Post.post_type_free).to eq [@free_post]
  end

  it 'Returns records for a column_not_state _type method' do
    expect(Post.post_type_not_free).to eq [@open_post]
  end

  it 'Returns records for a column_state method' do
    expect(Post.post_type('Open')).to eq [@open_post]
  end

  it 'Returns records for a column_state_not method' do
    expect(Post.post_type_not('Open')).to eq [@free_post]
  end

  Post::PUBLICATION_STATES.each do |state|
    it 'Has a query method for a #{state} state value' do
      expect(@post).to respond_to("publication_state_#{state.downcase}?")
    end

    it 'Has a non query method for a #{state} state value' do
      expect(@post).to respond_to("publication_state_not_#{state.downcase}?")
    end

    it 'Responds true to query method for a #{state} state value when in that state' do
      @post.publication_state = state
      expect(@post.send("publication_state_#{state.downcase}?")).to be_true
    end

    it 'Responds false to not query method for a #{state} state value when in that state' do
      @post.publication_state = state
      expect(@post.send("publication_state_not_#{state.downcase}?")).to be_false
    end

    it 'Responds false to query method for a #{state} state value when not in that state' do
      @post.publication_state = 'Invalid'
      expect(@post.send("publication_state_#{state.downcase}?")).to be_false
    end

    it 'Responds true to not query method for a #{state} state value when not in that state' do
      @post.publication_state = 'Invalid'
      expect(@post.send("publication_state_not_#{state.downcase}?")).to be_true
    end
  end

end
