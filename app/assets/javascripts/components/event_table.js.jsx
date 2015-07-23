var globalEmitter = new EventEmitter();

var es = new EventSource('/events/stream');

es.onmessage = function(event){
  globalEmitter.emit('change', JSON.parse(event.data));
}

var makeChangeEventMixin = function (emitter) {
    return {
        componentDidMount: function () {
            emitter.addListener('change', this.__makeChangeEventMixin_handler_);
        },
        componentWillUnmount: function () {
            emitter.removeListener('change', this.__makeChangeEventMixin_handler_);
        },
        __makeChangeEventMixin_handler_: function (payload) {
            console.log('__makeChangeEventMixin_handler_ fired with payload=%O', payload);
            //console.log('__makeChangeEventMixin_handler_ fired with event=%O', payload.event);
            //  console.log('__makeChangeEventMixin_handler_ fired with event=%O', payload['event'];
            //this.replaceState(payload);
            var eventrecord = JSON.parse(payload);
            //this.props.events[eventrecord.id]=eventrecord;
            this.props.events.push(eventrecord);
            this.forceUpdate();
        }
    };
};

var EventTable = React.createClass({
  mixins: [makeChangeEventMixin(globalEmitter)],
  render: function() {
    events = this.props.events
    console.log('Data: %O', events);
    return <table>
        <thead><tr><th>ID</th><th>Name</th><th>Eventable Type</th><th>Changes</th></tr></thead>
        <tbody>

      {events.map(function(result) {
          return <EventRow key={result.id} data={result} />;
      })}
            </tbody>
      </table>

  }
});

