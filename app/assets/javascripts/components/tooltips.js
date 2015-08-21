window.Survhey.Tooltips = (function () {
  // Super basic tooltips for ChartJS' customTooltips feature.
  // Custom tooltips allow us to style the tooltips just like we
  // want them, and most importantly, allows them to stretch
  // outside the canvas area.

  var tooltips = [];
  var $body = $(document.body);

  // showTooltip("my-tooltip-key", "Click me!", { x: 10, y: 20 });
  function showTooltip(label, options) {
    var $el = $(document.createElement("div"));
    var $countEl = $(document.createElement("span"));

    var labelParts = label.match(/^(\d+): (.+)$/);

    // This element holds the answers count:
    $countEl
      .addClass("tooltip-value")
      .text(labelParts[1]);

    // This is the actual tooltip:
    $el
      .text(labelParts[2])
      .addClass("tooltip")
      .offset({ top: options.y, left: options.x })
      .prepend($countEl)
      .appendTo($body);

    tooltips.push($el);
  }

  // hideTooltip("my-tooltip-key")
  function removeTooltips() {
    tooltips.forEach(function ($el) {
      $el.bind("webkitAnimationEnd oanimationend msAnimationEnd animationend", function () {
        $el.remove();
      });

      $el.addClass("tooltip--disappear");
    });
  }

  function chartJSHandler(tooltip) {
    if (!tooltip) {
      // Done!
      removeTooltips();
      return;
    }

    var offset = $(tooltip.chart.canvas).offset();
    var x = offset.left + tooltip.x;
    var y = offset.top + tooltip.y;

    showTooltip(tooltip.text, { x: x, y: y });
  }

  return {
    chartJS: chartJSHandler
  };
}());
