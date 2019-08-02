(function() {
  var wrapper = document.querySelector('.wrapper');
  var container = wrapper.querySelector('.container');
  var markdownToc = document.getElementById('markdown-toc');
  var onThisPage = document.getElementById('on-this-page');
  var titles = container.querySelectorAll('h1, h2:not(.no_toc), h3, h4, h5');

  if (markdownToc) {
    var tocs = document.createElement('aside');
    tocs.className = 'tocs-sidebar';
    tocs.innerHTML += '<h4>On this page</h4>';
    tocs.innerHTML += markdownToc.outerHTML;

    wrapper.classList.add('handbook-wrapper');
    wrapper.classList.add('clearfix');

    wrapper.insertBefore(tocs, container);

    [].slice.call(titles).forEach(function(el) {
      el.innerHTML += '<a href="#' + el.id + '" class="handbook-md-anchor"></a>';
      el.classList.add('handbook-md-title');
    });

    markdownToc.className += ' hidden-md hidden-lg';
    onThisPage.className += ' hidden-md hidden-lg';
  }
})();
