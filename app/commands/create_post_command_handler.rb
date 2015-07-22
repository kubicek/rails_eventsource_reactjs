class CreatePostCommandHandler < CommandHandler

  def eventable_type
    "Post"
  end

  def eventable_id
    post_id
  end

  def event_name
    "PostCreated"
  end

  def post_id
    Post.last.try(:id).to_i+1
  end

  def changes
    @post.changes.merge(id: [nil, post_id])
  end

  def perform
    @post = Post.new(params.require(:post).permit(:title, :body, :author_name))
  end

end
