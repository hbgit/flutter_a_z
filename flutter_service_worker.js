'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "9fbcc4aef28a6e07e93351f63b10e120",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/AssetManifest.json": "cd7f43645769faf9c87df072bfbdc159",
"/assets/LICENSE": "8483d01d74e1e7a6c72dfbc62125d51d",
"/assets/images/v7_img/youtube.png": "9bc925d99cd9a0718de36fb30d966bcc",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/main.dart.js": "f215531b4fa9fb1dfba71c70e4ad0ce0",
"/manifest.json": "267450d2e27a233810c283b77314b646"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
