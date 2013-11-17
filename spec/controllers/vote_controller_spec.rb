require 'spec_helper'

describe VoteController do
   
   describe "PUT update" do
     before(:each) {
     	@user = Factory(:user)
     	@user.roles << Factory(:role)
     	@post = Factory(:post, :user => @user)
     }
     it "should vote if not voted" do
     	sign_in @user
     	put 'update', {:post_id => @post.id ,:id => @post.vote.id, :vote => { :score => "Up" } }
        flash[:notice].should eq("You vote counted!")
        response.should redirect_to(post_path(@post))
     end
     it "should not vote if you have already voted" do
     	sign_in @user
     	put 'update', {:post_id => @post.id ,:id => @post.vote.id, :vote => { :score => "Up" } }
        put 'update', {:post_id => @post.id ,:id => @post.vote.id, :vote => { :score => "Up" } }
        flash[:notice].should eq("You have already voted")
        response.should redirect_to(post_path(@post))
     end
     it "should not vote if you can not abilitiy" do
        put 'update', {:post_id => @post.id ,:id => @post.vote.id, :vote => { :score => "Up" } }
        response.should redirect_to(post_path(@post))
        @post.vote.score.should eq(0) 	
     end  
   end

   describe "DELETE clear" do
     before(:each) {
       @user = Factory(:user)
       @user.roles << Factory(:role, :name => :admin)
       @post = Factory(:post, :user => @user)	
     }
     it "should clear if admin" do
       sign_in @user
       delete 'clear', { :id => @post.vote.id, :post_id => @post.id }
  	   flash[:notice].should eq("Clear!")
       response.should redirect_to(post_path(@post))
     end
     it "should not clear if user" do
       delete 'clear', { :id => @post.vote.id, :post_id => @post.id }
  	   response.should redirect_to(post_path(@post))
     end
   end
end
