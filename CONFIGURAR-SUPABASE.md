# Configurar o painel privado Mundo Martinho

## 1. Criar o projeto Supabase
1. Entre em https://supabase.com/ e crie um projeto.
2. Abra **Project Settings → API** (ou Connect) e copie a **Project URL** e a chave **anon / publishable**.
3. Não use a chave `service_role` no site, no painel ou no GitHub.

## 2. Criar a única conta administradora
1. No Supabase, abra **Authentication → Users → Add user**.
2. Crie o teu email e uma palavra-passe forte.
3. Copie o UUID desse utilizador.

## 3. Criar tabelas e regras de segurança
1. Abra **SQL Editor → New query**.
2. Em `supabase-schema.sql`, O UUID do administrador já foi preenchido neste pacote. Não é necessário substituí-lo.
3. Execute o SQL completo.

O SQL cria `mm_services`, `mm_portfolio`, `mm_feedbacks`, o bucket `mm-public` e as políticas RLS. A leitura é pública porque os conteúdos são apresentados no site; só o UUID do administrador pode inserir, editar ou apagar.

## 4. Configurar o site
`supabase-config.js` já está configurado com a URL, chave pública e UUID fornecidos. Nunca publique `service_role`, senha do banco ou tokens privados.

## 5. Publicar
Envie os ficheiros atualizados para a raiz do GitHub e aguarde o Render.
- Site: `https://mundo-martinho.onrender.com/`
- Painel: `https://mundo-martinho.onrender.com/admin.html`

Entre com a conta criada no passo 2.

## 6. Utilização
No painel, escolha Serviços, Portfólio ou Feedbacks e use **Adicionar**. Pode carregar imagens diretamente; serão guardadas no bucket Supabase `mm-public`.

O site consulta primeiro o Supabase. Se não estiver configurado, falhar ou a tabela estiver vazia, mantém os JSON atuais como alternativa. O SQL também importa os quatro serviços e os dois projetos que já estavam no ZIP, sem duplicá-los se o script for executado novamente. Os feedbacks começam vazios, conforme o ficheiro original.

## Segurança
- Ative MFA na conta Supabase.
- `admin.html` não é protegido por estar escondido; a proteção real é Auth + RLS.
- `adicionar.html` é a ferramenta antiga de preparação manual, não é o painel privado. Use `admin.html` para gerir os conteúdos.
