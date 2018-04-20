---
title: Comment puis-je collecter des métriques à partir du shell UNIX?
kind: faq
---

Pour rassembler des métriques à partir de la ligne de commande UNIX, nous pouvons utiliser l'intégration shell.

This integration has not yet been merged into the master branch, install this check as a custom check in the appropriate Datadog Agent [directories][1].

Vous pouvez trouver les fichiers d'intégration sur GitHub:

* [Shell YAML Example][2]
* [Shell checks.d][3]

This solution is a good alternative to creating a custom check for data you can easily gather directly from the UNIX shell. For example, sending a metric with a value of the number of files in a certain directory.

Caveat: 

The user that the Agent runs as may need sudo access for the shell command. Sudo access is not required when running the Agent as root (not recommended).

[1]: /agent/agent_checks/#directory
[2]: https://github.com/DataDog/dd-agent/blob/garner/shell-integration/conf.d/shell.yaml.example
[3]: https://github.com/DataDog/dd-agent/blob/garner/shell-integration/checks.d/shell.py