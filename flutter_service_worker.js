'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "9fbcc4aef28a6e07e93351f63b10e120",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/assets/assets/images/v9_img/195.jpg": "132164f0ef044145ae124e258d29a07b",
"/assets/assets/images/v9_img/json/songs.json": "eb8bf119b358f90989bb3604d68f96d9",
"/assets/FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/AssetManifest.json": "2d791c06b34a05dec95e5fcc4476b011",
"/assets/LICENSE": "76ad06766052a61fbdbfa7b8c9f4a4b1",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/main.dart.js": "3fb684ca9b69a95ff1b8f190c0fc167d",
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
