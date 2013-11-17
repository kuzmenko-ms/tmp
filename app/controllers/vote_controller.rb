class VoteController < ApplicationController
	
  load_and_authorize_resource
	
  def update
	  post = Post.find(params[:post_id])
    vote = post.vote
      
    vote.score += 1 if params[:vote][:score] == "Up" 
    vote.score -= 1 if params[:vote][:score] == "Down"
    vote.users << current_user
    vote.save

    flash[:notice] = "You vote counted!"
    redirect_to post_path(post)	
	end

	def clear
    post = Post.find(params[:post_id])
    post.vote.update_attributes(:score => 0)
    
    flash[:notice] = "Clear!" 
    redirect_to post_path(post)
	end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "ushze vce" 
    redirect_to post_path(Post.find(params[:post_id]))
  end

end
