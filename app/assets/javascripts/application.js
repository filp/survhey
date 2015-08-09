//= require jquery
//= require jquery_ujs
//= require Chart
//= require_tree .

// :)

$(function () {

  var canvas = document.getElementById("results-graph");

  if (canvas) {
    var ctx = canvas.getContext("2d");
    var data = JSON.parse($(canvas).attr("data-graph"));

    new Chart(ctx).Doughnut(data, {
      animateScale: true,
      responsive: true
    });
  }
});
