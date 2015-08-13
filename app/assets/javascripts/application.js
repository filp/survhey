//= require jquery
//= require jquery_ujs
//= require react
//= require react_ujs
//= require Chart
//= require ./config
//= require_tree ./components

// :)

$(function () {
  // Select the contents of the account link input field when it's focused:
  $(".account-link-url").click(function () {
    $(this).select();
  });
});
