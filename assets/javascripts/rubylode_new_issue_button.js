// Adds the New issue button. The address and the label come from the server (data-href, data-label on this
// script tag). The button goes in front of the search box; where a page has no search box it goes first in the header.
(function () {
  var script = document.currentScript;
  if (!script || !script.dataset.href) return;

  var container = document.getElementById('quick-search') || document.getElementById('header');
  if (!container || container.querySelector('.rubylode-new-issue-button')) return;

  var button = document.createElement('a');
  button.className = 'rubylode-new-issue-button';
  button.href = script.dataset.href;
  button.textContent = script.dataset.label || 'New issue';
  container.insertBefore(button, container.firstChild);
})();
