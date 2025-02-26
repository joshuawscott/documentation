---
categories:
- Source Control
ddtype: crawler
dependencies: []
description: Envoyez des commits et pull requests depuis votre serveur Git auto-hébergé vers Datadog.
doc_link: https://docs.datadoghq.com/integrations/git/
git_integration_title: git
has_logo: true
integration_title: Git
is_public: true
kind: integration
manifest_version: '1.0'
name: git
public_title: Intégration Datadog/Git
short_description: Envoyez des commits et pull requests depuis votre serveur Git auto-hébergé vers Datadog.
  to Datadog.
version: '1.0'
---

{{< img src="integrations/git/git_event.png" alt="Événement Git" responsive="true" popup="true">}}

## Présentation

Enregistrez des commits Git directement depuis votre serveur Git pour ;

* Surveiller les changements de code en temps réel
* Ajouter des indicateurs de changement de code sur l'ensemble de vos dashboards
* Discuter des changements de code avec votre équipe

## Implémentation
### Installation

1. Créez une nouvelle clé d'application pour Git : [générer une clé d'application][1].

2. Téléchargez le webhook Datadog/Git :
```
sudo easy_install dogapi
curl -L https://raw.github.com/DataDog/dogapi/master/examples/git-post-receive-hook > post-receive
```

3. Configurez Git avec vos [clés Datadog][2] :
```
git config datadog.api <VOTRE_CLÉ_API_DATADOG>
git config datadog.application <VOTRE_CLÉ_APP_DATADOG>
```   

4. Activez le webhook dans votre référentiel.
```
install post-receive git_repository/.git/hooks/post-receive
```
(en partant du principe que votre référentiel s'intitule ```git_repository```)

4. Installez l'intégration.

[1]: https://app.datadoghq.com/account/settings#api
[2]: https://app.datadoghq.com/account/settings#api


{{< get-dependencies >}}
