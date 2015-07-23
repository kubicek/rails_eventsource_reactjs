# rails_eventsource_reactjs
Sample Ruby on Rails app with event sourcing and reactjs interface

Usage

	# git clone git@github.com:kubicek/rails_eventsource_reactjs.git
	# cd rails_eventsource_reactjs
	# bundle
	# rake db:migrate
	# rails c Puma
	# open http://localhost:5000
	# open http://localhost:5000/events

Event stream debug

	# telnet localhost 5000
	GET /events/stream HTTP/1.1
	Host: localhost:5000
	Accept: text/event-stream
