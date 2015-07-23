var EventRow = React.createClass({
  propTypes: {
    name: React.PropTypes.string,
    eventableType: React.PropTypes.string,
    key: React.PropTypes.string,
    data: React.PropTypes.object
  },

  render: function() {
    var eventrecord = this.props.data
    return (
          <tr>
            <td>{eventrecord.id}</td>
            <td>{eventrecord.name}</td>
            <td>{eventrecord.eventable_type}</td>
            <td>{eventrecord.data.changes.title[1]}</td>
          </tr>
    );
  }
});

