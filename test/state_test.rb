require 'test_helper'

class StateTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = Post
    end
    should "set the correct expected values for a column_state _state method" do
      expected =<<-SQL
      SELECT "posts".* FROM "posts" WHERE ("posts"."publication_state" = 'Draft')
      SQL
      assert_equal expected.strip, @class.publication_state_draft.to_sql
    end
    should "set the correct expected values for a column_not_state _state method" do
      expected =<<-SQL
      SELECT "posts".* FROM "posts" WHERE ("posts"."publication_state" <> 'Draft')
      SQL
      assert_equal expected.strip, @class.publication_state_not_draft.to_sql
    end
    should "set the correct expected values for a column_state _type method" do
      expected =<<-SQL
      SELECT "posts".* FROM "posts" WHERE ("posts"."post_type" = 'PostModern')
      SQL
      assert_equal expected.strip, @class.post_type_postmodern.to_sql
    end
    should "set the correct expected values for a column_not_state _type method" do
      expected =<<-SQL
      SELECT "posts".* FROM "posts" WHERE ("posts"."post_type" <> 'PostModern')
      SQL
      assert_equal expected.strip, @class.post_type_not_postmodern.to_sql
    end
    should "set the correct expected values for a column_state method" do
      expected =<<-SQL
      SELECT "posts".* FROM "posts" WHERE ("posts"."post_type" = 'PostModern')
      SQL
      assert_equal expected.strip, @class.post_type('PostModern').to_sql
    end
    should "set the correct expected values for a column_state_not method" do
      expected =<<-SQL
      SELECT "posts".* FROM "posts" WHERE ("posts"."post_type" <> 'PostModern')
      SQL
      assert_equal expected.strip, @class.post_type_not('PostModern').to_sql
    end
  end

  context "A Post" do
    setup do
      @post = Post.new
      assert_not_nil Post::PUBLICATION_STATES
    end
    Post::PUBLICATION_STATES.each do |state|
      context "with a #{state} state value" do
        should "have a query method" do
          assert @post.respond_to?("publication_state_#{state.downcase}?")
        end
        should "have a non query method" do
          assert @post.respond_to?("publication_state_not_#{state.downcase}?")
        end
        context "when in that state" do
          setup { @post.publication_state = state }
          should "respond true to query method" do
            assert @post.send("publication_state_#{state.downcase}?")
          end
          should "respond false to not query method" do
            assert ! @post.send("publication_state_not_#{state.downcase}?")
          end
        end
        context "when not in that state" do
          setup { @post.publication_state = 'Invalid' }
          should "respond false to query method" do
            assert ! @post.send("publication_state_#{state.downcase}?")
          end
          should "respond true to not query method" do
            assert @post.send("publication_state_not_#{state.downcase}?")
          end
        end
      end
    end
  end

end
