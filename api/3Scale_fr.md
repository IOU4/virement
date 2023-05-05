# utiliser 3Scale api management pour gérer l'api Transactions :

## Qu'est-ce que 3Scale :

3scale API Management est une plateforme de gestion et de sécurisation des API. Elle fournit une suite d'outils pour contrôler l'accès aux API, surveiller l'utilisation et analyser les performances. Avec 3scale, les développeurs peuvent facilement créer et publier des API, tout en appliquant des politiques d'authentification, de limitation de débit et d'autres mesures de sécurité. La plateforme comprend également des fonctions d'analyse et de reporting, permettant aux développeurs de suivre l'utilisation et les performances de leurs API. 3scale API Management simplifie le processus de gestion et de sécurisation des API, aidant les organisations à améliorer l'efficacité, à réduire les coûts et à améliorer l'expérience des utilisateurs.
Il y a deux termes importants dans 3scale :
- Backend : Se réfère à l'infrastructure côté serveur qui alimente une API. Cela inclut les points d'extrémité de l'API, toutes les bases de données ou autres services sur lesquels l'API s'appuie, et le code du backend qui traite les demandes et renvoie les réponses.
- Produit : Se réfère à un ensemble d'API liées qui sont regroupées et offertes aux développeurs en tant que paquet unique. Un produit dans 3scale peut inclure une ou plusieurs API, et peut avoir ses propres politiques d'authentification et d'utilisation, des limites de taux, et des analyses. 3scale fournit des outils pour gérer et surveiller la performance de chaque produit, et pour personnaliser le portail du développeur et la documentation pour chaque produit.

## Comment utiliser 3Scale pour gérer notre api :

### Configuration de la plateforme :

  Allez sur [3scale.net](https://www.3scale.net/signup) et créez un compte avec le sous-domaine désiré.
  ![3scale singup](https://iou4.github.io/hosted_assets/images/3scale_singup.png)

  Vérifiez votre email et accédez au tableau de bord.

### hébergement de l'api :

3scale ne peut pas accéder à localhost, donc l'api doit être hébergée d'une manière ou d'une autre, ici nous avons utilisé un outil gratuit appelé [Serveo](http://serveo.net/) qui utilise ssh pour rediriger le trafic http vers un port local.

Pour héberger l'api :
  - assurez-vous que tous les services sont opérationnels et que l'api est accessible sur le port 8082.
  - Assurez-vous d'avoir `Openssh` sur votre machine.
  - Exécutez
    ``bash
    $ ssh -R eai-api:80:localhost:8082 serveo.net
    ```

  Exemple : ![serveo.png](https://iou4.github.io/hosted_assets/images/serveo.png)


### Enregistrer l'api :

Allez maintenant sur votre tableau de bord 3scale, dans le menu déroulant de l'en-tête, choisissez 'backends'.
![backends](https://iou4.github.io/hosted_assets/images/backends.png)

Cliquez sur create backend et remplissez les champs avec le nom désiré, system_name et description, le dernier champ doit être le lien vers l'api dans notre cas c'est `https://eai-api.serveo.net:443`

Soumettez les informations en cliquant sur create backend.
  ![create_backend](https://iou4.github.io/hosted_assets/images/create_backend.png)

### Ajouter des méthodes et les mapper :

Dans 3scale API Management, une méthode se réfère à une opération ou une action spécifique qui peut être effectuée sur une ressource API après avoir été mappée à un chemin.

pour ajouter une méthode :
  - assurez-vous que vous êtes dans la page backend créée et cliquez sur 'Methods and Metrics' :
  ![add_method](https://iou4.github.io/hosted_assets/images/add_method.png)
  ![méthode](https://iou4.github.io/hosted_assets/images/method.png)
  - ajoutez ensuite une règle de mappage pour la méthode nouvellement créée en cliquant sur 'add mapping rule' :
  ![create_mapping](https://iou4.github.io/hosted_assets/images/create_mapping.png)
  choisissez le chemin souhaité pour la méthode, qui doit être identique à celui fourni par l'api
  ![mapping](https://iou4.github.io/hosted_assets/images/mapping.png)
  maintenant nous devrions voir le mapping
  ![success_mapping](https://iou4.github.io/hosted_assets/images/mapping_list.png)

### Ajouter le backend au produit :

Dans 3scale API Management, un produit est une collection d'un ou plusieurs backends qui sont regroupés et offerts aux développeurs comme un paquet unique.

pour ajouter le backend :
  - naviguez jusqu'au produit :
  ![liste_de_produits](https://iou4.github.io/hosted_assets/images/product_list.png)
  - Allez à navigation->backends dans le menu latéral et cliquez sur "ajouter un backend" :
  ![product_backends](https://iou4.github.io/hosted_assets/images/product_backens.png)
  - dans le menu déroulant, choisissez le backend créé et choisissez un chemin à utiliser comme préfixe pour accéder aux ressources du backend, c'est-à-dire que si nous voulons récupérer '/api/virements' de l'api et que nous avons '/x' comme préfixe dans 3scale, nous devrions demander '/x/api/virements'. cliquez sur 'add to product' (ajouter au produit)
  ![add_backend_to_product](https://iou4.github.io/hosted_assets/images/add_product_backend.png)


### Soumettre des changements :

3Scale offre un mécanisme d'étape pour tester les changements avant de les promouvoir en production.
Dans le tableau de bord du produit, allez dans intégration >> configuration (il devrait y avoir un signe d'avertissement).
  - dans stage, cliquez sur promote to staging, après quoi vous pouvez utiliser l'url fournie pour tout tester avant de passer en production.
  ![3scale_stagin](https://iou4.github.io/hosted_assets/images/3scale_stagin.png)
  - pour passer à la production, cliquez sur "promouvoir v.x vers Production APIcast" et utilisez l'url de production pour accéder aux ressources.
  ![3scale_production](https://iou4.github.io/hosted_assets/images/3scale_production.png)

## Utilisation de RH-SSO pour sécuriser l'accès à l'api :
La gestion de l'api 3Scale supporte plusieurs méthodes d'autorisation, pour sécuriser l'accès au produit. Nous sommes intéressés par RH-SSO :
 - Dans le tableau de bord du produit, allez dans Intégration >> Paramètres >> Authentification et choisissez 'OpenID Connect', dans Type d'émetteur OpenID Connect choisissez 'Red Hat Single Sign On',
 Obtenez l'url de l'émetteur à partir de l'instance RH-SSO. Accordez ensuite le flux de code d'autorisation, puis cliquez tout en bas sur "mettre à jour le produit" et validez les changements dans le menu de configuration.
 ![3scale_rhsso](https://iou4.github.io/hosted_assets/images/3scale_rhsso.png)

## Test :

Suivre [RHSSO.md]() pour configurer et rhsso.
#### pour obtenir un jeton d'accès :

Faire une requête post (avec le type de contenu -form-urlencoded) au point d'accès au jeton de rhsso qui est dans notre cas `https://eai-rhsso.serveo.net/auth/realms/eai-poc/protocol/openid-connect/token` avec
- `grant_type=client_credentials`
- `client_id=<<votre identifiant client>>`
- `client_secret=<<votre secret client>>`
- `scope=openid`

vous devriez recevoir une réponse json ok avec le jeton d'accès.

Exemple :
![token_success](https://iou4.github.io/hosted_assets/images/success_token.png)

#### accède à l'api :

Avec le jeton d'accès disponible, nous pouvons l'utiliser pour authentifier notre accès à 3scale, il suffit de l'utiliser dans l'en-tête de la requête comme un jeton Bearer.
exemple :
![api_success](https://iou4.github.io/hosted_assets/images/success_api.png)

