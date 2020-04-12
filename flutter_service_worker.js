'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "9fbcc4aef28a6e07e93351f63b10e120",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/AssetManifest.json": "62d28eb7ed589961ce2b4d84291b1dba",
"/assets/LICENSE": "832c683862cb4bf3929f34d31416f01b",
"/assets/images/v5_img/logo.png": "1a4e05af51006dcadefbaa65872bcfc6",
"/assets/images/v5_img/moeda_coroa.png": "c3e301a258a8f9b3a3e09549cca4b735",
"/assets/images/v5_img/botao_jogar.png": "0faa94c13b40da8688108306601e1ea7",
"/assets/images/v5_img/moeda_cara.png": "f6b337d27683ac1157d8e0b07401e9a2",
"/assets/images/v5_img/botao_voltar.png": "d226fb50a5f6ef9ce7bcf8663bd27f74",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/main.dart.js": "3ba6e9d9b1c35de3a66d271f3e401493",
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
