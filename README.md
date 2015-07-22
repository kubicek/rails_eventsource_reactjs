# rails_eventsource_reactjs
Sample Ruby on Rails app with event sourcing and reactjs interface

SSE Example

	# rails c Puma

	# telnet localhost 3000
	GET /events/stream HTTP/1.1
	Host: localhost:3000
	Accept: text/event-stream

