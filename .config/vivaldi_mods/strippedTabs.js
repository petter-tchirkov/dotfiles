(() => {
  const CLASS_EVEN = "even";
  const CLASS_ODD = "odd";

  const applyStripeClasses = () => {
    const tabs = document.querySelectorAll(".tab");
    tabs.forEach((tab, index) => {
      tab.classList.remove(CLASS_EVEN, CLASS_ODD);
      tab.classList.add(index % 2 === 0 ? CLASS_EVEN : CLASS_ODD);
    });
  };

  let rafId = 0;
  const scheduleUpdate = () => {
    if (rafId) {
      return;
    }
    rafId = requestAnimationFrame(() => {
      rafId = 0;
      applyStripeClasses();
    });
  };

  const observer = new MutationObserver(scheduleUpdate);

  const start = () => {
    applyStripeClasses();
    observer.observe(document.body, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: ["class"],
    });
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start, { once: true });
  } else {
    start();
  }
})();
