// ── DEPLOY VERSION ──────────────────────────────────────────
// 배포할 때마다 이 날짜를 업데이트하면 자동으로 새 캐시가 생성됩니다.
// Update this date on every deploy to bust the cache.
const DEPLOY = 'bcf44440';
const CACHE  = 'rest-v' + DEPLOY;

const PRECACHE = [
  '/time/',
  '/time/index.html',
  '/time/manifest.json',
  '/time/icon.svg',
  '/time/icon-192.png',
  '/time/icon-512.png',
];

// ── Install: cache all assets ───────────────────────────────
self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE).then(c => c.addAll(PRECACHE))
  );
  // 기존 SW를 기다리지 않고 즉시 활성화
  self.skipWaiting();
});

// ── Activate: delete old caches & claim clients ─────────────
self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys =>
        Promise.all(
          keys.filter(k => k !== CACHE).map(k => caches.delete(k))
        )
      )
      .then(() => self.clients.claim())
      // 새 버전이 활성화되면 모든 열린 탭에 reload 신호 전송
      .then(() =>
        self.clients.matchAll({ type: 'window' }).then(clients =>
          clients.forEach(c => c.postMessage({ type: 'NEW_VERSION' }))
        )
      )
  );
});

// ── Fetch: HTML은 network-first, 나머지는 cache-first ────────
self.addEventListener('fetch', e => {
  const { request } = e;
  const url = new URL(request.url);

  // 같은 origin의 요청만 처리
  if (url.origin !== location.origin) return;

  const isDocument =
    request.mode === 'navigate' ||
    request.destination === 'document' ||
    url.pathname.endsWith('/') ||
    url.pathname.endsWith('.html');

  if (isDocument) {
    // Network-first: 네트워크에서 최신 HTML을 가져오고
    // 실패(오프라인)하면 캐시에서 서빙
    e.respondWith(
      fetch(request)
        .then(res => {
          const clone = res.clone();
          caches.open(CACHE).then(c => c.put(request, clone));
          return res;
        })
        .catch(() => caches.match(request))
    );
  } else {
    // Cache-first: 아이콘·manifest 등 정적 에셋은 캐시 우선
    e.respondWith(
      caches.match(request).then(cached => cached || fetch(request))
    );
  }
});
