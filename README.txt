MUNDO MARTINHO — WEBSITE DIGITAL

Ficheiros:
- index.html: site completo, HTML/CSS/JavaScript reunidos num único ficheiro.
- logo.png: logotipo PNG.
- config.json: configurações gerais da marca, slogan e WhatsApp.
- config/servis.json: catálogo dos serviços; fácil de adicionar, editar ou desactivar.

PERSONALIZAÇÃO:
1. Edite config.json para alterar marca, slogan, contacto e indicativos.
2. Edite config/servis.json para alterar, acrescentar ou desactivar serviços.
3. Mantenha os nomes dos campos id, name, icon, short e enabled nos serviços.

IMPORTANTE:
O site pode ser aberto directamente em index.html. Por restrições de segurança do navegador,
JSON externo pode não ser lido quando o ficheiro é aberto com file://; nesse modo, o site
usa dados de fallback embutidos no index.html. Em alojamento/servidor web, lê os JSON externos.
Para alterações de serviços que também devam aparecer no modo file://, actualizar os dados de
fallback no script do index.html.

O formulário só revela o botão de WhatsApp depois de seleccionar pelo menos um serviço,
preencher nome, número de WhatsApp e descrição. O pedido abre uma mensagem pré-formatada.
Não são apresentados preços ou prazos fixos.
