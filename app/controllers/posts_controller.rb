class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :redirect_root, except: [:index, :new, :create, :show]

    def index
        @user = User.find(params[:user_id])
        @posts = @user.posts.order("created_at DESC").page(params[:page]).per(5)
    end

    def new
        @post = Post.new
    end

    def create
        Post.create(post_params)
        redirect_to root_path
    end

    def show 
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        if post.user == current_user 
            post.update(post_params)
        end
        redirect_to root_path
    end

    def destroy_confirm
        @post = Post.find(params[:id])
    end

    def destroy 
        post = Post.find(params[:id])
        if post.user == current_user 
            post.destroy
        end
        redirect_to root_path
    end

    private

    def redirect_root
        post = Post.find(params[:id])
        if post.user != current_user 
            redirect_to root_path
        end
    end

    def post_params
        params.require(:post).permit(:title, :text, :image).merge(user_id: current_user.id)
    end

end
