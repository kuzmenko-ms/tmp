require 'spec_helper'

describe PostsController do
  
  
  describe "GET index" do
    it "assign all posts" do
      post = Factory(:post)
      get 'index'
      assigns(:posts).should eq([post])
      response.should render_template('posts/index')
    end
  end
  
  describe "GET show" do
    it "should show post" do
      post = Factory(:post)
      get 'show', {:id => post.id}
      assigns(:post).should eq(post)
      response.should render_template('posts/show')
    end	
  end

  describe "GET new" do
    before(:each) {
      @user = Factory(:user)
      @user.roles << Factory(:role)	
      sign_in @user
    }
    it "ssigns a new post as @post if User have ability :user" do
      get 'new'
      assigns(:post).should be_a_new(Post)
      response.should render_template('posts/new')
    end
    it "asigns a new post as @post if User have ability :admin" do
      @user.roles.clear
      @user.roles << Factory(:role, :name => :admin)
      get 'new'
      assigns(:post).should be_a_new(Post)
      response.should render_template('posts/new')
    end
    it "ssigns a new post as @post if User have not ability :user" do
      sign_out @user
      get 'new'
      response.should redirect_to(root_url)
    end
  end

  describe "GET edit" do
    before(:each) {
      @user = Factory(:user)
      @user.roles << Factory(:role)
      @post = Factory(:post, :user => @user)
    }
    it "can edit post if i'm author this post" do
      sign_in @user
      get 'edit', {:id => @post.id }
      assigns(:post).should eq(@post)
      response.should render_template('posts/edit') 	
    end
    it "can edit post if i'm the admin" do
      @user.roles.clear
      @user.roles << Factory(:role, :name => :admin)
      sign_in @user
      get 'edit', {:id => @post.id}
      assigns(:post).should eq(@post)
      response.should render_template('posts/edit') 		
    end
    it "can not edit post if not author" do
      user = Factory(:user)
      sign_in user
      get 'edit', {:id => @post.id}
      response.should redirect_to(root_url)	
    end
    it "can not edit post if not authorized" do
      get 'edit', {:id => @post.id}
      response.should redirect_to(root_url)  	
    end  
  end

  describe "POST create" do
  	context "should create post if params is valid" do
      before(:each) {
      	@attr = {
      		:title   => "new title.",
      		:content => "new content."
      	}
      }
      it "should create post if user can create post" do
        user = Factory(:user)
        user.roles << Factory(:role)
        sign_in user
        post 'create', {:post => @attr}

        response.should redirect_to(post_path(Post.last))
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted 
      end	
      it "redirect_to root_url if user can not create post" do
        post 'create', {:post => @attr}
        response.should redirect_to(root_url)
      end
    end
    context "should not create post if params is not valid" do
      it "should re-render new template if params is invalid" do
        attr = {:title => "new title"}
        
        user = Factory(:user)
        user.roles << Factory(:role)
        sign_in user
        post 'create', {:post => @attr}
        
        response.should render_template('posts/new')
      end	
    end		
  end

  describe "PUT update" do
  	before(:each) {
      @user = Factory(:user)
      @user.roles << Factory(:role)
      @post = Factory(:post, :user => @user)
    }
    it "should update post if it is my post" do
      sign_in @user
      put 'update', { :id => @post.id, :post => {:title => 'update title'}}
      response.should redirect_to(post_path(@post))
    end
    it "should update post if i'm the admin" do
      @user.roles.clear
      @user.roles << Factory(:role, :name => :admin)
      sign_in @user
      put 'update', { :id => @post.id, :post => {:title => 'update title'}}
      response.should redirect_to(post_path(@post)) 	
    end
    it "should not update post if it is not my post" do
      user = Factory(:user)
      user.roles << Factory(:role)
      sign_in user
      put 'update', { :id => @post.id, :post => {:title => 'update title'}}
      response.should redirect_to(root_url)	
    end
    it "should not update post and redirect_to root_url if i can not ability" do
      put 'update', { :id => @post.id, :post => {:title => 'update title'}}
      response.should redirect_to(root_url)
    end   
  end

  describe "DELETE destroy" do
  	before(:each) {
  	  @user = Factory(:user)
      @user.roles << Factory(:role)
      @post = Factory(:post, :user => @user)	
  	}
  	it "should delete post if i am the admin" do
  	  @user.roles.clear
  	  @user.roles << Factory(:role, :name => :admin)
  	  sign_in @user
  	  delete 'destroy', { :id => @post.id }
  	  flash[:notice].should eq("Delete")
  	  response.should redirect_to(posts_path)	
  	end
  	it "should not delete post if i am author" do
  	  sign_in @user
  	  delete 'destroy', { :id => @post.id }
  	  response.should redirect_to(root_url)	
  	end
  	it "should not delete post if i am guest" do
  	  delete 'destroy', { :id => @post.id }
  	  response.should redirect_to(root_url)	
  	end
  end
  
  	

end