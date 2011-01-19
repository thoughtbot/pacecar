require 'spec_helper'

describe 'State' do

  before do
    @draft_post = Factory :post, :publication_state => 'Draft'
    @final_post = Factory :post, :publication_state => 'Final'
    @free_post = Factory :post, :post_type => 'Free'
    @open_post = Factory :post, :post_type => 'Open'

    @post = Post.new
    Post::PUBLICATION_STATES.should_not be_nil
  end

  it "should set the correct expected values for a column_state _state method" do
    Post.publication_state_draft.should == [@draft_post]
  end

  it "should set the correct expected values for a column_not_state _state method" do
    Post.publication_state_not_draft.should == [@final_post]
  end

  it "should set the correct expected values for a column_state _type method" do
    Post.post_type_free.should == [@free_post]
  end

  it "should set the correct expected values for a column_not_state _type method" do
    Post.post_type_not_free.should == [@open_post]
  end

  it "should set the correct expected values for a column_state method" do
    Post.post_type('Open').should == [@open_post]
  end

  it "should set the correct expected values for a column_state_not method" do
    Post.post_type_not('Open').should == [@free_post]
  end

  Post::PUBLICATION_STATES.each do |state|
    it "should have a query method for a #{state} state value" do
      @post.should respond_to("publication_state_#{state.downcase}?")
    end

    it "should have a non query method for a #{state} state value" do
      @post.should respond_to("publication_state_not_#{state.downcase}?")
    end

    it "should respond true to query method for a #{state} state value when in that state" do
      @post.publication_state = state
      @post.send("publication_state_#{state.downcase}?").should be_true
    end

    it "should respond false to not query method for a #{state} state value when in that state" do
      @post.publication_state = state
      @post.send("publication_state_not_#{state.downcase}?").should be_false
    end

    it "should respond false to query method for a #{state} state value when not in that state" do
      @post.publication_state = 'Invalid'
      @post.send("publication_state_#{state.downcase}?").should be_false
    end

    it "should respond true to not query method for a #{state} state value when not in that state" do
      @post.publication_state = 'Invalid'
      @post.send("publication_state_not_#{state.downcase}?").should be_true
    end
  end

end
