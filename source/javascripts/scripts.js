// eslint-disable-next-line no-unused-vars
function openSocialLink(link, width, height) {
  var left = (window.innerWidth / 2) - (width / 2);
  var top = (window.innerHeight / 2) - (height / 2);

  window.open(link.href, 'targetWindow', 'menubar=no,status=no,resizable=no,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
}

// eslint-disable-next-line consistent-return
function getUrlParameter(sParam) {
  var sPageURL = window.location.search.substring(1);
  var sURLVariables = sPageURL.split('&');
  for (var i = 0; i < sURLVariables.length; i++) {
    var sParameterName = sURLVariables[i].split('=');
    if (sParameterName[0] === sParam) {
      return sParameterName[1];
    }
  }
}

