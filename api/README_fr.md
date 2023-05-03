# Transactions Api :

## Prérequis :

  - [Docker](https://www.docker.com/) :
      Docker est une plateforme de développement, d'expédition et d'exécution d'applications utilisant la technologie de conteneurisation. Elle permet aux développeurs d'empaqueter leurs applications et leurs dépendances dans des conteneurs légers et portables qui peuvent être exécutés de manière cohérente dans différents environnements, du développement à la production. Docker facilite la création, le déploiement et la gestion des applications, tout en améliorant l'évolutivité et en réduisant les coûts d'infrastructure.
  - Docker Compose] (https://docs.docker.com/compose/install/) :
      Nous utilisons Docker Compose dans notre projet pour définir et exécuter des applications multi-conteneurs, y compris notre base de données PostgreSQL et notre API. Docker Compose utilise un fichier YAML pour spécifier la configuration de chaque conteneur, ce qui facilite le démarrage et le démontage d'environnements complexes à l'aide d'une seule commande.
  - Docker Buildx] (https://docs.docker.com/build/install-buildx/) :
      buildx est fourni par docker et permet de construire des images docker à partir d'un fichier docker. Nous l'utilisons dans notre projet pour construire une image docker pour notre api à partir du code source.
  - JDk 17] (https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html)
      jdk doit être installé et configuré correctement sur la machine pour pouvoir construire le fichier jar avec gradle.

## Exécution des services Api :

construire d'abord le fichier jar de java avec la commande suivante :

``bash
$ ./gradlew api:bootJar
```
Ici nous construisons le fichier jar avec le nom `api` avec gradle pour être utilisé plus tard dans dockerfile pour construire l'image, si nous vérifions le répertoire `build/libs/` il devrait y avoir un fichier appelé `api-0.1.jar` qui est l'application spring boot désirée.

exemple de construction réussie : ![bootJar en action](https://raw.githubusercontent.com/IOU4/virement/main/assets/bootJar.png?token=GHSAT0AAAAAAB352HX3VFNVN4IXB2ASXHJ6ZCLCNMA)

Ensuite, nous construisons l'image docker avec la commande suivante :
``bash
$ cd api
$ docker buildx build -t eai/api .
```
Ici nous construisons une image docker avec le nom `eai/api` en utilisant docker buildx pour être utilisée plus tard dans le fichier docker compose.

Voici un exemple de construction réussie : ![docker buildx](https://raw.githubusercontent.com/IOU4/virement/main/assets/buildx.png?token=GHSAT0AAAAAAB352HX3KAIEKMMQ2A6OGZ3KZCLCPDQ)

Enfin, démarrez les services (base de données et API) avec docker compose en utilisant la commande suivante :
``bash
$ docker compose up -d
```
nous utilisons le drapeau `-d` pour nous détacher du terminal, vous pouvez vérifier que les services sont en cours d'exécution avec la commande suivante :
``bash
$ docker ps
```
exemple d'exécution réussie : ![successful compose](https://raw.githubusercontent.com/IOU4/virement/main/assets/compose.png?token=GHSAT0AAAAAAB352HX3KNATE7I5U5G7EMHMZCLCPNA)

super ! tout est fait, maintenant l'api devrait être accessible à : [localhost:8082](http://localhost:8082/)

