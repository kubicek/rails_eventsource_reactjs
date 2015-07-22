class Command < ActiveRecord::Base
  # you can access and expect only one event or many event depending on usecase
  has_one :event
  has_many :events

  belongs_to :requestor, polymorphic: true

  store :metadata, coder: JSON
  store :data, accessors: [:params], coder: JSON

  def self.perform(current_user, command_name, metadata, params)
    command = create(name: command_name, metadata: metadata,
      params: params, requestor: current_user)
    CommandHandler.perform(command)
  end
end
