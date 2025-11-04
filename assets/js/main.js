// js cho navbar
(function () {
  function ready(fn) {
    if (document.readyState !== "loading") fn();
    else document.addEventListener("DOMContentLoaded", fn);
  }

  function debounce(fn, wait) {
    var t;
    return function () {
      var ctx = this,
        args = arguments;
      clearTimeout(t);
      t = setTimeout(function () {
        fn.apply(ctx, args);
      }, wait);
    };
  }

  // Track scroll direction and speed
  var lastScrollTop = 0;
  var scrollSpeed = 0;
  var lastScrollTime = Date.now();

  ready(function () {
    var menu = document.querySelector(".navbar__menu");
    var subnav = document.querySelector(".navbar__subnav");
    var wrapper = document.querySelector(".navbar__wrapper");
    if (!menu) return;

    // show the navbar with slide-in animation
    requestAnimationFrame(function () {
      menu.classList.add("visible");
    });

    // handle scroll direction and speed
    function handleScroll() {
      var st = window.scrollY;
      var now = Date.now();
      var timeDiff = now - lastScrollTime;

      // Calculate scroll speed (pixels per millisecond)
      if (timeDiff > 0) {
        scrollSpeed = Math.abs(st - lastScrollTop) / timeDiff;
      }

      // Determine scroll direction and apply classes
      if (st > 50) {
        // Only start hiding when scrolled a bit
        var scrollingDown = st > lastScrollTop;

        // Add shadow to menu when scrolled
        menu.classList.add("scrolled");

        // Hide everything when scrolling down fast enough
        if (scrollingDown && scrollSpeed > 0.5) {
          wrapper.classList.add("hidden");
          subnav.classList.add("hidden");
          document.body.classList.add("subnav-hidden");
          menu.classList.remove("visible");
        }
        // Show menu (only) when scrolling up
        else if (!scrollingDown) {
          wrapper.classList.add("hidden");
          subnav.classList.add("hidden");
          document.body.classList.add("subnav-hidden");
          menu.classList.add("visible");
        }
      } else {
        // At top - show everything
        menu.classList.remove("scrolled");
        wrapper.classList.remove("hidden");
        subnav.classList.remove("hidden");
        document.body.classList.remove("subnav-hidden");
        menu.classList.add("visible");
      }

      lastScrollTop = st;
      lastScrollTime = now;
    }

    var debounced = debounce(handleScroll, 30);
    window.addEventListener("scroll", handleScroll, { passive: true });
    // initial check
    handleScroll();
  });
})();