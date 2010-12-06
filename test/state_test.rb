require 'test_helper'

class StateTest < ActiveSupport::TestCase

  setup do
    @draft_post = Factory :post, :publication_state => 'Draft'
    @final_post = Factory :post, :publication_state => 'Final'
    @free_post = Factory :post, :post_type => 'Free'
    @open_post = Factory :post, :post_type => 'Open'

    @post = Post.new
    assert_not_nil Post::PUBLICATION_STATES
  end

  test "set the correct expected values for a column_state _state method" do
    assert_equal [@draft_post], Post.publication_state_draft
  end

  test "set the correct expected values for a column_not_state _state method" do
    assert_equal [@final_post], Post.publication_state_not_draft
  end

  test "set the correct expected values for a column_state _type method" do
    assert_equal [@free_post], Post.post_type_free
  end

  test "set the correct expected values for a column_not_state _type method" do
    assert_equal [@open_post], Post.post_type_not_free
  end

  test "set the correct expected values for a column_state method" do
    assert_equal [@open_post], Post.post_type('Open')
  end

  test "set the correct expected values for a column_state_not method" do
    assert_equal [@free_post], Post.post_type_not('Open')
  end

  Post::PUBLICATION_STATES.each do |state|
    test "have a query method for a #{state} state value" do
      assert @post.respond_to?("publication_state_#{state.downcase}?")
    end

    test "have a non query method for a #{state} state value" do
      assert @post.respond_to?("publication_state_not_#{state.downcase}?")
    end

    test "respond true to query method for a #{state} state value when in that state" do
      @post.publication_state = state
      assert @post.send("publication_state_#{state.downcase}?")
    end

    test "respond false to not query method for a #{state} state value when in that state" do
      @post.publication_state = state
      assert ! @post.send("publication_state_not_#{state.downcase}?")
    end

    test "respond false to query method for a #{state} state value when not in that state" do
      @post.publication_state = 'Invalid'
      assert ! @post.send("publication_state_#{state.downcase}?")
    end

    test "respond true to not query method for a #{state} state value when not in that state" do
      @post.publication_state = 'Invalid'
      assert @post.send("publication_state_not_#{state.downcase}?")
    end
  end

end
