class UpdatePostCommandHandler < CommandHandler

  def eventable_type
    "Post"
  end

  def eventable_id
    @post.id
  end

  def event_name
    "PostUpdated"
  end

  def changes
    @post.changes
  end

  def perform
    @post = Post.find(params[:id])
    @post.attributes=params.require(:post).permit(:title, :body, :author_name)
  end

end
