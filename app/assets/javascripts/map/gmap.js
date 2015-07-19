var stockholm = new google.maps.LatLng(59.32522, 18.07002);
var parliament = new google.maps.LatLng(59.327383, 18.06747);
var marker;
var map;

function initialize() {
  var mapOptions = {
    zoom: 13,
    center: parliament
  };

  map = new google.maps.Map(document.getElementById('map-canvas'),
          mapOptions);

  marker = new google.maps.Marker({
    map:map,
    draggable:true,
    animation: google.maps.Animation.DROP,
    position: parliament
  });
  google.maps.event.addListener(marker, 'click', toggleBounce);
}

function toggleBounce() {

  if (marker.getAnimation() != null) {
    marker.setAnimation(null);
  } else {
    marker.setAnimation(google.maps.Animation.BOUNCE);
  }
}

google.maps.event.addDomListener(window, 'load', initialize);


//to pin drop on an address
// map here is your google.map.Map element

  //   var myLatlng = new google.maps
  //   geocoder.geocode({ 'address': addressThatYouWannaDraw }, function (results, status) {
  //   if (status == google.maps.GeocoderStatus.OK) {
  //     pt = results[0].geometry.location;

  //     var myMarkerOpts = {
  //       position: pt,
  //       map: map
  //     };

  //     var marker = new google.maps.Marker(myMarkerOpts);
  //   }
  // });

//experiment!!
// function initialize() {
//   var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
//   var mapOptions = {
//     zoom: 8,
//     center: myLatlng
//   }
//   var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
//   var marker = new google.maps.Marker({
//     position: myLatlng,
//     map: map,
//     title: 'Hello World!'
//   });
// }

// google.maps.event.addDomListener(window, 'load', initialize);
