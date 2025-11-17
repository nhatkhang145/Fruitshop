// Dán vào file: settings.js
document.addEventListener("DOMContentLoaded", () => {
  const settingsTabs = document.querySelectorAll(".settings-container .tab-link");
  const settingsPanes = document.querySelectorAll(".settings-content .tab-pane");
  if (settingsTabs.length === 0) return; // Thoát

  settingsTabs.forEach((tab) => {
    tab.addEventListener("click", (e) => {
      e.preventDefault();
      const tabId = tab.dataset.tab;
      settingsTabs.forEach((t) => t.classList.remove("active"));
      tab.classList.add("active");
      settingsPanes.forEach((pane) => pane.classList.remove("active"));
      const activePane = document.getElementById(tabId);
      if (activePane) {
        activePane.classList.add("active");
      }
    });
  });
});