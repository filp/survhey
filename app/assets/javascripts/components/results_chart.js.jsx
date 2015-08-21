window.Survhey.ResultsChart = (function () {

  var ResultsChart = React.createClass({
    propTypes: {
      data: React.PropTypes.array.isRequired,
      id: React.PropTypes.string.isRequired
    },

    componentDidMount: function () {
      var canvas = React.findDOMNode(this.refs.canvas);

      var ctx = canvas.getContext("2d");
      var chart = new Chart(ctx).Doughnut(this.props.data, {
        animateScale: true,
        animationSteps: 80,
        responsive: true,
        customTooltips: Survhey.Tooltips.chartJS,
        tooltipTemplate: "<%= value %><%if (label){%>: <%= label %> <%}%>"
      });

      this.setState({ chart: chart });
    },

    render: function () {
      return (
        <canvas id={this.props.id} ref="canvas"></canvas>
      );
    }
  });

  return ResultsChart;
}());
