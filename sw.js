const V='mm-v3',CORE=['./','index.html','config.json','services.json','portfolio.json','feedbacks.json','logo.webp','1.webp','2.webp','favicon.png','manifest.webmanifest'];
self.addEventListener('install',e=>{e.waitUntil(caches.open(V).then(c=>c.addAll(CORE)).then(()=>self.skipWaiting()))});
self.addEventListener('activate',e=>{e.waitUntil(caches.keys().then(k=>Promise.all(k.filter(x=>x!==V).map(x=>caches.delete(x)))).then(()=>self.clients.claim()))});
self.addEventListener('fetch',e=>{
  const r=e.request; if(r.method!=='GET'||new URL(r.url).origin!==location.origin) return;
  const fresh=/\.json$|\/$|index\.html$/.test(r.url.split('?')[0]);
  e.respondWith(fresh
    ? fetch(r).then(res=>{const cp=res.clone();caches.open(V).then(c=>c.put(r,cp));return res}).catch(()=>caches.match(r))
    : caches.match(r).then(h=>h||fetch(r).then(res=>{const cp=res.clone();caches.open(V).then(c=>c.put(r,cp));return res})));
});
