class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :set_parent, only: %i[show new create]
  def index
    @comments = @post.comments.where(parent_id: nil)
  end

  def new
    @parent = Comment.find_by(id: params[:parent_id])
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.parent = @parent
    @comment.save
  end

  def show; end

  def edit; end

  def destroy
    @comment.destroy
  end

  def update
    @comment.update(comment_params)
  end
    
    private
  
    def set_post
      @post = Post.find_by(id: params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:content)
    end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def set_parent
    @parent = Comment.find_by(id: params[:parent_id])
  end
end
