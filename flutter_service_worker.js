'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "98a8e246cf3391a9047685fe5b0dbfdf",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "267450d2e27a233810c283b77314b646",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/assets/v11/defaultUser.png": "7d61448ff9aacb86e27323ec612b9e9f",
"assets/assets/v11/logo.png": "6acbfc9a5f176ae66db826d5182c5bc5",
"assets/assets/v11/background.jpg": "cbdbadac0968f89a26e059816d406336",
"assets/assets/v11/usuario.png": "1e2751a1f7bd7a155b8119a9806828f8",
"assets/AssetManifest.json": "3860e5c4b45114e27b95dba469d01e4e",
"assets/LICENSE": "098563bd2220c70512552fd053ba27db",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"index.html": "9cf2d24eb0be6ba9da88690278db0bef",
"/": "9cf2d24eb0be6ba9da88690278db0bef"
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
