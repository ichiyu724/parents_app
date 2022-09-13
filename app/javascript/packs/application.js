// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

require("jquery");
require("bootstrap");
import "../stylesheets/application.scss";

$(window).on("scroll", function () {
  let scrollHeight = $(document).height();
  let scrollPosition = $(window).height() + $(window).scrollTop();
  if ((scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $(".jscroll").jscroll({
      contentSelector: ".scroll-list",
      nextSelector: "span.next:last a",
    });
  }
});

const pageTop = $("#js-pagetop");
const scroll = 50;

$(window).on("scroll", () => {
  if ($(this).scrollTop() > scroll) {
    pageTop.fadeIn();
  } else {
    pageTop.fadeOut();
  }
});

const speed = 500;
pageTop.on("click", () => {
  $("body, html").animate(
    {
      scrollTop: 0,
    },
    speed
  );
  return false;
});
