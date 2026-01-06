'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a4352a4d0ae911851b100bf343e2c3cc",
"assets/AssetManifest.bin.json": "4a5eb64b734a0c8d29289a21605cafb7",
"assets/assets/fonts/Open_Sans/static/OpenSans_Condensed-Bold.ttf": "9a8b3d4395da2a08ae86ec6392408b78",
"assets/assets/fonts/Open_Sans/static/OpenSans_Condensed-Light.ttf": "1a444a0c7de382541bd4e852676adb6b",
"assets/assets/icons/icon-config-roxo.png": "644ca60bc8f18cba1be0c0d9cf48c5fc",
"assets/assets/icons/icon-dicas-produtividade.png": "7b508fe5506c2ee2e30612b605d1511b",
"assets/assets/icons/icon-estatistica-roxo.png": "1baf6fc6284cd9593c9c96a05d585f09",
"assets/assets/icons/icon-selo-meta-semanal.png": "ec1fa0d5712bde56382b0ee13ece09b7",
"assets/assets/icons/icon-semana.png": "dcdd46a80c0410aabace8493eea5378f",
"assets/assets/icons/icon-sequencia.png": "4b71506160824caaf22b26c1bab87f3c",
"assets/assets/icons/icon-tarefas-ativas.png": "1fc95fd43601e0e88d0d68659d5f1f8c",
"assets/assets/icons/icon-tarefas-concluidas.png": "6466bf87e227e0035e758ad523371c2a",
"assets/assets/icons/icon-tarefas-criadas.png": "fa995fd33a72ffb5ccb73ef631b90b65",
"assets/assets/icons/icon_ajuda.png": "4581054391256bc8ae1f46574398134e",
"assets/assets/icons/icon_casa.png": "af1bf5acb14c648672b20e017d74a7da",
"assets/assets/icons/icon_categorias_cinza.png": "04f68bc440404d27df4ede2286c612a5",
"assets/assets/icons/icon_categorias_roxo.png": "9005eccdfc66c07d6acf4ff5d9af7baa",
"assets/assets/icons/icon_compras.png": "e49e4f0eba4a7ac425163388f848414f",
"assets/assets/icons/icon_config_cinza.png": "60cf648ec34365736db85ed084f0ada0",
"assets/assets/icons/icon_coracao.png": "1c658417dc6271ec79123c30cf4c7b32",
"assets/assets/icons/icon_email.png": "592112613f4284560ae21fcd470c4ddd",
"assets/assets/icons/icon_esportes.png": "a008f85a87cb0af935298bebfbf28c1b",
"assets/assets/icons/icon_estatistica_cinza.png": "e562e137907b5175403a46ba0cbed84f",
"assets/assets/icons/icon_familia.png": "a878f53e280ec78dc52323545344b79a",
"assets/assets/icons/icon_lazer.png": "13a673fa1cc2b60dce9a1f422c52b7e1",
"assets/assets/icons/icon_livro.png": "fb8be3d056b0177b799f58e3d1cc4626",
"assets/assets/icons/icon_metas_cinza.png": "2b0556645c30dad5e38c259297318676",
"assets/assets/icons/icon_metas_roxo.png": "269fbb8e4bc4f762dcb1df5961968a0d",
"assets/assets/icons/icon_person.png": "b6501d81501c0c796487e1fb0db7dff1",
"assets/assets/icons/icon_senha.png": "b1a0a2ffc093c9b3e1faebacaedb9941",
"assets/assets/icons/icon_tarefas_cinza.png": "18b7bb42b5acd3e6144b3ec85bb0e940",
"assets/assets/icons/icon_tarefas_roxo.png": "c7c1f10375dd691b8fb14cb6dc4ff943",
"assets/assets/icons/icon_trabalho.png": "169137c1d3064e3114d9a0f84518cba3",
"assets/assets/images/foto_perfil.png": "fa44d90b54e54c0f62c645e0f09dd056",
"assets/assets/images/google.png": "fff932b60b2df0c06f909fd743823710",
"assets/assets/images/LOGO.png": "e501da1f48aaa185be8d2c58e80de41d",
"assets/assets/images/LOGO.svg": "222aa68939f8b1359c14c518b2d460a1",
"assets/assets/images/splash_logo.png": "e501da1f48aaa185be8d2c58e80de41d",
"assets/FontManifest.json": "e1aa15af5667aa5e0f612aa81bea4f90",
"assets/fonts/MaterialIcons-Regular.otf": "c58046f0af70ef35fe2e355a953bb2e8",
"assets/NOTICES": "9f94ada3c230182c60cffc422c5588ac",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "46dd967813fdc5c2c4449ef97f2e7e90",
"icons/apple-touch-icon.png": "34c477af5bd60fb69f4ab447720be823",
"icons/favicon.ico": "1d35302a7e4bb355ac85c8987dc4ed78",
"icons/icon-192-maskable.png": "00d0660e9648e3362741379a8014b00d",
"icons/icon-192.png": "ed504a692c04d101538bd56272a2ba6c",
"icons/icon-512-maskable.png": "f3ef9a3973c12022db7c1101e5af509f",
"icons/icon-512.png": "43491dde6781543a14ee33ff02a4b2a6",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f57e48c5cc5f869a51c99d1c7ae60505",
"/": "f57e48c5cc5f869a51c99d1c7ae60505",
"main.dart.js": "326825b533f5d7bcfaccaa74741cb003",
"manifest.json": "3ff04903185eb1246436508c0e3ad83b",
"splash/img/dark-1x.png": "240c0cf4cb9440cee5d261cab8fb5325",
"splash/img/dark-2x.png": "ebdcc6ba895739a042e04d9be0a1ccc9",
"splash/img/dark-3x.png": "23463da5b8b7c75b85af27ac61bda247",
"splash/img/dark-4x.png": "ccf12804585e71c5b6a1411d52c66347",
"splash/img/light-1x.png": "240c0cf4cb9440cee5d261cab8fb5325",
"splash/img/light-2x.png": "ebdcc6ba895739a042e04d9be0a1ccc9",
"splash/img/light-3x.png": "23463da5b8b7c75b85af27ac61bda247",
"splash/img/light-4x.png": "ccf12804585e71c5b6a1411d52c66347",
"version.json": "52f0a9c990d44cad66fdc5f965a103ea"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
