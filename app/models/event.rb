class Event < ActiveRecord::Base
  belongs_to :command
  #belongs_to :requestor, foreign_key: :requestor_id, class: Person
  belongs_to :eventable, polymorphic: true

  store :metadata, coder: JSON
  store :data, accessors: [:changes], coder: JSON

  before_create :set_uuid
  before_create "apply!"
  before_create :publish

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def apply!
    ch={}
    changes.each{|k,v| ch[k]=v[1]}
    # puts "CHANGES: #{changes.inspect}"
    if eventable
      if changes["id"] && changes["id"][0]==eventable_id && changes["id"][1]==nil
        eventable.destroy
      else
        ch.delete("id")
        eventable.update_attributes ch
      end
    else
      eventable_type.constantize.create(ch)
    end
  end

  def publish
    Notifier.publish "events", self.to_json
  end

  def self.replay!(start_id=nil)
    events = all.order(id: :asc)
    events = events.where("id >= ?", start_id) if start_id
    events.each do |event|
      event.apply!
      event.publish
    end
  end
end
