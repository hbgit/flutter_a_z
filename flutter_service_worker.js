'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "9fbcc4aef28a6e07e93351f63b10e120",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/AssetManifest.json": "f2fea8fd8a8880d4e0c9bb818196baa3",
"/assets/LICENSE": "fa78e10b637fde9c5a64cbcef8a6e371",
"/assets/images/papel.png": "ada35938120c7c8b2a3164cc58fe1756",
"/assets/images/pedra.png": "db796ff45155ea8c0ced267298d1bb48",
"/assets/images/tesoura.png": "d8f126622a2a6bb4ad64fd5ed5b35a8a",
"/assets/images/padrao.png": "589c46b59101f6116106c88f390fb683",
"/assets/images/logo_main_book.jpg": "f8f84fdf4d60a6ea9d53c6f352d2cd99",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/main.dart.js": "a5a1405c51cd68a9de634ecf59bef15f",
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
