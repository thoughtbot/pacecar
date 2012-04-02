require 'spec_helper'

describe 'Associations', 'has recent records' do

  before do
    @comment_user = create :user
    @post_user = create :user
    @both_user = create :user
    create :comment, :user => @comment_user, :created_at => 10.days.ago
    create :comment, :user => @comment_user, :created_at => 3.days.ago
    create :post, :owner => @post_user, :created_at => 10.days.ago
    create :post, :owner => @post_user, :created_at => 3.days.ago

    create :comment, :user => @both_user, :created_at => 10.days.ago
    create :comment, :user => @both_user, :created_at => 3.days.ago
    create :post, :owner => @both_user, :created_at => 10.days.ago
    create :post, :owner => @both_user, :created_at => 3.days.ago
  end

  it "should set the correct options for a recent methods for one association" do
    User.recent_comments_since(5.days.ago).should == [@comment_user, @both_user]
  end

  it "should set the correct options for a recent methods combining associations with or" do
    User.recent_posts_or_comments_since(5.days.ago).should == [@comment_user, @post_user, @both_user]
  end

  it "should set the correct options for a recent methods combining associations with and" do
    User.recent_posts_and_comments_since(5.days.ago).should == [@both_user]
  end

end
