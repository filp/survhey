//= require jquery
//= require jquery_ujs
//= require Chart
//= require_tree .

// :)

$(function () {

  // If the results graph is present on the page, render it:
  var canvas = document.getElementById("results-graph");
  if (canvas) {
    var ctx = canvas.getContext("2d");
    var data = JSON.parse($(canvas).attr("data-graph"));

    new Chart(ctx).Doughnut(data, {
      animateScale: true,
      animationSteps: 80,
      responsive: true
    });
  }

  // Select the contents of the account link input field when it's focused:
  $(".account-link-url").click(function () {
    $(this).select();
  });
});
