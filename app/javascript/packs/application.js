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
