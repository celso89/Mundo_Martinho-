-- MUNDO MARTINHO | executar no Supabase SQL Editor
-- 1) Crie primeiro o utilizador em Authentication > Users.
-- 2) Copie o UUID e substitua b819aa81-e964-4af3-9e51-32d18a7e087a abaixo.
-- 3) Execute este ficheiro completo.

create table if not exists public.mm_services (
  id bigint primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
create table if not exists public.mm_portfolio (
  id uuid primary key default gen_random_uuid(),
  data jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.mm_feedbacks (
  id uuid primary key default gen_random_uuid(),
  data jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Conteúdos iniciais do site original (executados apenas se as tabelas estiverem vazias).
insert into public.mm_services (id,data) values
(1,'{"id":1,"name":"Website Profissional / Landing Page","desc":"Desenvolvimento web focado em conversão. Design responsivo, otimização SEO (Google) e carregamento ultrarrápido.","category":"websites","image":"1.webp","icon":"globe","price":"A partir de 25.000 Kz","priceFrom":25000,"badge":"Websites","popular":true,"features":["Design responsivo","SEO otimizado","Subdomínio incluído"],"en":{"name":"Professional Website / Landing Page","desc":"Conversion-focused web development. Responsive design, Google SEO and lightning-fast loading.","price":"From 25,000 Kz","badge":"Websites","features":["Responsive design","SEO optimised","Subdomain included"]}}'::jsonb),
(2,'{"id":2,"name":"Automação de WhatsApp","desc":"Atendimento automático 24/7. Integração com catálogo, respostas inteligentes, agendamentos e disparo de mensagens.","category":"bots","image":"2.webp","icon":"bot","price":"Sob Consulta","priceFrom":0,"badge":"Automação","popular":false,"features":["Atendimento 24/7","Catálogo e pedidos","Agendamentos"],"en":{"name":"WhatsApp Automation","desc":"24/7 automatic support. Catalogue integration, smart replies, bookings and message broadcasting.","price":"On Request","badge":"Automation","features":["24/7 support","Catalogue & orders","Bookings"]}}'::jsonb),
(3,'{"id":3,"name":"Aplicação Móvel (Android/iOS)","desc":"Apps nativas e híbridas com UI/UX moderno. Ideal para e-commerce, serviços de entrega ou área de membros.","category":"apps","image":"","icon":"phone","price":"Sob Consulta","priceFrom":0,"badge":"Mobile","popular":false,"features":["Android e iOS","UI/UX moderno","E-commerce e entregas"],"en":{"name":"Mobile App (Android/iOS)","desc":"Native and hybrid apps with modern UI/UX. Ideal for e-commerce, delivery services or member areas.","price":"On Request","badge":"Mobile","features":["Android & iOS","Modern UI/UX","E-commerce & delivery"]}}'::jsonb),
(4,'{"id":4,"name":"Sistema de Gestão (ERP)","desc":"Software de gestão à medida. Controlo de stock, faturação, gestão de clientes (CRM) e relatórios financeiros.","category":"software","image":"","icon":"server","price":"Sob Consulta","priceFrom":0,"badge":"Enterprise","popular":false,"features":["Stock e faturação","CRM de clientes","Relatórios financeiros"],"en":{"name":"Management System (ERP)","desc":"Tailor-made management software. Stock control, invoicing, customer management (CRM) and financial reports.","price":"On Request","badge":"Enterprise","features":["Stock & invoicing","Customer CRM","Financial reports"]}}'::jsonb)
on conflict (id) do nothing;
insert into public.mm_portfolio (data)
select v.data from (values
('{"title":"FransMat Burger — Site de encomendas","title_en":"FransMat Burger — Online ordering website","category":"websites","client":"FransMat Burger","description":"Site de encomendas de hambúrgueres, cachorros quentes e combos, com menu e preços, carrinho e formulário de encomenda.","description_en":"Online ordering website for burgers, hot dogs and combos, with menu and prices, cart and order form.","image":"fransmat-capa.webp","images":["fransmat-1.webp","fransmat-2.webp"],"tags":["Website","Encomendas online","Menu digital"]}'::jsonb),
('{"title":"Nicolau Assistance — Sistema de gestão","title_en":"Nicolau Assistance — Management system","category":"software","client":"Nicolau Assistance","description":"Sistema de gestão para assistência técnica: ordens de serviço com PDF, clientes, stock de peças, finanças, relatórios, contas de funcionários e backup.","description_en":"Management system for a repair shop: service orders with PDF, customers, parts stock, finance, reports, staff accounts and backup.","image":"nicolau-capa.webp","images":["nicolau-1.webp","nicolau-2.webp"],"tags":["Gestão financeira","Ordens de serviço","Stock","Backup"]}'::jsonb)) as v(data)
where not exists (select 1 from public.mm_portfolio);

alter table public.mm_services enable row level security;
alter table public.mm_portfolio enable row level security;
alter table public.mm_feedbacks enable row level security;

drop policy if exists "public read services" on public.mm_services;
create policy "public read services" on public.mm_services for select to anon, authenticated using (true);
drop policy if exists "admin manages services" on public.mm_services;
create policy "admin manages services" on public.mm_services for all to authenticated
using (auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid)
with check (auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid);

drop policy if exists "public read portfolio" on public.mm_portfolio;
create policy "public read portfolio" on public.mm_portfolio for select to anon, authenticated using (true);
drop policy if exists "admin manages portfolio" on public.mm_portfolio;
create policy "admin manages portfolio" on public.mm_portfolio for all to authenticated
using (auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid)
with check (auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid);

drop policy if exists "public read feedbacks" on public.mm_feedbacks;
create policy "public read feedbacks" on public.mm_feedbacks for select to anon, authenticated using (true);
drop policy if exists "admin manages feedbacks" on public.mm_feedbacks;
create policy "admin manages feedbacks" on public.mm_feedbacks for all to authenticated
using (auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid)
with check (auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid);

-- Bucket público para imagens publicadas no site.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('mm-public', 'mm-public', true, 8388608, array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true, file_size_limit = 8388608;

drop policy if exists "public reads mm media" on storage.objects;
create policy "public reads mm media" on storage.objects for select to anon, authenticated
using (bucket_id = 'mm-public');
drop policy if exists "admin uploads mm media" on storage.objects;
create policy "admin uploads mm media" on storage.objects for insert to authenticated
with check (bucket_id = 'mm-public' and auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid);
drop policy if exists "admin updates mm media" on storage.objects;
create policy "admin updates mm media" on storage.objects for update to authenticated
using (bucket_id = 'mm-public' and auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid)
with check (bucket_id = 'mm-public' and auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid);
drop policy if exists "admin deletes mm media" on storage.objects;
create policy "admin deletes mm media" on storage.objects for delete to authenticated
using (bucket_id = 'mm-public' and auth.uid() = 'b819aa81-e964-4af3-9e51-32d18a7e087a'::uuid);
