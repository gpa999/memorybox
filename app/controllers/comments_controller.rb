class CommentsController < ApplicationController

    def create
        post = Post.find(params[:post_id])
        comment = Comment.create(text: comment_params[:text], user_id:current_user.id, post_id:post.id)
        redirect_to post_path(post)
    end
    
    private

    def comment_params
      params.require(:comment).permit(:text)
    end

end
