# Mundo Martinho — como atualizar o site

O site lê tudo de ficheiros simples. **Não precisa mexer no `index.html`.**

| O quê | Ficheiro | Pasta das fotos |
|---|---|---|
| Projetos que já fez | `portfolio.json` | `portfolio/` |
| Feedbacks dos clientes | `feedbacks.json` | `feedbacks/` |
| Serviços, preços, prémios, WhatsApp, textos | `services.json` e `config.json` | `1.webp`, `2.webp` |

As secções **Projetos** e **Feedbacks** (e o botão no menu) aparecem sozinhas quando houver pelo menos 1 item.

## Jeito mais fácil (recomendado)
1. Abra `https://mundo-martinho.onrender.com/adicionar.html` no telemóvel ou PC.
2. Escolha **Projeto feito** ou **Feedback de cliente**, escolha a foto (é otimizada automaticamente), preencha e toque **Gerar código**.
3. No GitHub: envie a foto otimizada para a pasta (`portfolio` ou `feedbacks`) em *Add file → Upload files*; depois abra o `.json`, toque no lápis, **apague tudo, cole o código copiado** e faça *Commit changes*.
4. Em 1–3 minutos o Render atualiza o site.

## Jeito manual (campos de cada item)
**portfolio.json**
```json
{ "title": "Loja da Maria", "category": "websites", "client": "Maria Lda",
  "description": "Site com catálogo e pedidos por WhatsApp.",
  "result": "+40% de pedidos", "image": "loja-maria.webp",
  "images": ["extra-1.webp", "extra-2.webp"],
  "date": "2026-11-20", "link": "https://exemplo.com", "tags": ["Website", "SEO"] }
```
Categorias: `websites`, `bots`, `apps`, `software` (ou outra palavra = aparece só em "Todas").

**feedbacks.json**
```json
{ "name": "João Pedro", "role": "Gerente, Loja X", "rating": 5,
  "text": "Entregaram antes do prazo e o atendimento é excelente.",
  "image": "print-joao.webp", "project": "Website profissional", "date": "2026-11-20" }
```
`image` é opcional (print da conversa de WhatsApp). `text` pode ficar vazio se só tiver o print.

**Dicas**
- `images` (opcional): mais capturas do mesmo projeto, aparecem como miniaturas por baixo da foto principal.
- Itens são ordenados por `date` (mais recentes primeiro). Use sempre `AAAA-MM-DD`.
- Separe itens com vírgula e não deixe vírgula depois do último. Se o JSON tiver erro, só essa secção some (o resto do site continua a funcionar).
- Fotos: até ~1400 px de largura, formato `.webp` ou `.jpg` (o `adicionar.html` já faz isto).
- Para inglês, adicione `title_en`, `description_en`, `result_en`, `text_en`, `project_en`.
- Só publique feedbacks reais e com autorização do cliente.

## Partilhar e QR Code
O ícone de partilha (topo e rodapé) abre o QR Code e os botões de WhatsApp, Facebook, X, Telegram, LinkedIn, Email, SMS, Instagram e TikTok. O QR é o ficheiro `qr.png` e aponta para `https://mundo-martinho.onrender.com`. Se mudar de domínio, é preciso gerar um QR novo e substituir `qr.png` (e atualizar `siteUrl` em `config.json`).


## Painel privado (novo)
- Painel: `admin.html` (acesso por Supabase Auth).
- Configuração: `supabase-config.js`.
- SQL de tabelas, permissões e importação inicial: `supabase-schema.sql`.
- Guia passo a passo: `CONFIGURAR-SUPABASE.md`.

Depois de configurar Supabase, usa `admin.html` para gerir serviços, projetos e feedbacks. O site público dá prioridade aos dados do Supabase e mantém os JSON como fallback. Nunca coloques a chave `service_role` no frontend.
