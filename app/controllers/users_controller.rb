class UsersController < ApplicationController
    before_action :authenticate_user!, except: :show
    before_action :redirect_root, only: [:edit, :update]

    def show
        @user = User.find(params[:id])
    end

    def edit 
        @user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        if user == current_user 
            user.update(user_params)
        end
        redirect_to user_path
    end

    def followed_posts
        posts_id = []
        current_user.followings.each do |user|
            user.posts.each do |post|
                posts_id << post.id
            end
        end
        @posts = Post.where(id: posts_id).order("created_at DESC").page(params[:page]).per(5)
    end

    def follower_index
        user = User.find(params[:id])
        @users = user.followers
    end

    def following_index
        user = User.find(params[:id])
        @users = user.followings
    end

    private

    def redirect_root
        user = User.find(params[:id])
        if user != current_user 
            redirect_to root_path
        end
    end

    def user_params
        params.require(:user).permit(:image, :text)
    end

end
