class PostsController < ApplicationController
  
  load_and_authorize_resource
  # GET /posts
  # GET /posts.json

  def search
    
    @data = Post.all.find_all{|x| x.dep == params[:dep]}
    puts ">>>>>>", params[:dep], @data.size
    respond_to do |format|
      format.js   {}
      format.json {  }
    end
  end

  def index
    @posts = Post.all
    @departments = Department.all

    #gon.departments = @departments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
      format.json { render json: @departments }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @departments = Department.all
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
@departments = Department.all
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
  @departments = Department.all
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
  @departments = Department.all
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
  @departments = Department.all
    @post = Post.find(params[:id])
     

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Delete" }
      format.json { head :no_content }
    end
  end
end
