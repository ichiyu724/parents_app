document.addEventListener("turbolinks:load", function () {
  const PageTopBtn = document.getElementById("js-pagetop");
  PageTopBtn.addEventListener("click", () => {
    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  });
});
