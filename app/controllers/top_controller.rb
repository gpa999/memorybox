class TopController < ApplicationController
    def index
        @posts = Post.search(params[:search]).order("created_at DESC").page(params[:page]).per(5)
    end
end
