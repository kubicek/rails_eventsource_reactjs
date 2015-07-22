class CommandHandler

  attr_reader :command

  def initialize(command)
    @command=command
  end

  def self.all
    [
      {command: "CreatePost", command_handler: "CreatePostCommandHandler"},
      {command: "UpdatePost", command_handler: "UpdatePostCommandHandler"},
      {command: "DeletePost", command_handler: "DeletePostCommandHandler"}
    ]
  end

  def self.find_by_command(name)
    all.detect{|command| command[:command]==name.to_s.camelize}
  end

  def self.initialize_handler_by_command(command)
    find_by_command(command.name)[:command_handler].constantize.new(command)
  end

  def self.perform(command)
    handler = initialize_handler_by_command(command)
    handler.validate
    handler.perform
    handler.notify
  end

  def params
    ActionController::Parameters.new(command.params)
  end

  def validate; end
  def perform; end
  def notify
    command.events.create(
      name: event_name,
      changes: changes,
      eventable_type: eventable_type,
      eventable_id: eventable_id
    )
  end

end
