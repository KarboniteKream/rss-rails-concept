class UtilController < ApplicationController
  def create
	if params[:function].eql? "read"
		if params[:do].eql? "Mark as read"
			Unread.where("user_id = ? AND article_id = ?", session[:userID], params[:id]).delete_all
		else
			Unread.new(:user_id => session[:userID], :article_id => params[:id].to_i).save
		end
	elsif params[:function].eql? "like"
		if params[:do].eql? "Like"
			Unread.where("user_id = ? AND article_id = ?", session[:userID], params[:id]).delete_all
			Liked.new(:user_id => session[:userID], :article_id => params[:id].to_i).save
		else
			Liked.where("user_id = ? AND article_id = ?", session[:userID], params[:id]).delete_all
		end
	end

	render :nothing => true
  end
end
