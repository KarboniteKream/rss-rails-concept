class LandingController < ApplicationController
  helper_method :featured
  def featured
	Article.joins("JOIN likeds ON id = likeds.article_id").select("articles.id, articles.title, articles.url, articles.author, articles.date, articles.content").group("likeds.article_id").order("COUNT(likeds.article_id) DESC")
  end

  def register
	if params[:password].eql? params[:password_confirmation]
		user = User.new(params.require(:user).permit(:real_name, :email, :password))

		if user.save
			session[:userID] = user.id
			redirect_to controller: "home", action: "feed"
			return
		else
			flash[:notice] = "BAD"
			render "index"
		end
	end
  end

  def signin
	salt = User.where("email = ?", params[:user][:email]).first.salt

	password = BCrypt::Engine.hash_secret(params[:user][:password], salt)

    user = User.where("email = ? AND encrypted_password = ?", params[:user][:email], password)

	if user.count > 0
		session[:userID] = user.first.id
		redirect_to controller: "home", action: "feed"
		return
	end

	render "index"
  end
end
