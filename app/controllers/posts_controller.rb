class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :redirect_root, except: [:index, :new, :create, :show]

    def index
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
