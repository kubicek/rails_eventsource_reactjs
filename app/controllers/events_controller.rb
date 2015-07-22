class EventsController < ApplicationController

  include ActionController::Live

  def stream
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.subscribe('events') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data.to_json }\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

end
