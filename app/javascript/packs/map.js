let map;

function initMap() {
  geocoder = new google.maps.Geocoder();

  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 40.7828, lng: -73.9653 },
    zoom: 12,
  });

  marker = new google.maps.Marker({
    position: { lat: 40.7828, lng: -73.9653 },
    map: map,
  });
}
