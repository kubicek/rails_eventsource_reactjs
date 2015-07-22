class DeletePostCommandHandler < CommandHandler

  def eventable_type
    "Post"
  end

  def eventable_id
    @post.id
  end

  def event_name
    "PostDeleted"
  end

  def changes
    # nullify all attributes == destroy object
    changes = @post.attributes
    changes.each{|k,v| changes[k]=[v, nil]}
    changes
  end

  def perform
    @post = Post.find(params[:id])
  end

end
