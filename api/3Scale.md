# using 3Scale api management to manage the Transactions api:

## What is 3Scale:

3scale API Management is a platform for managing and securing APIs. It provides a suite of tools for controlling access to APIs, monitoring usage, and analyzing performance. With 3scale, developers can easily create and publish APIs, while also enforcing policies for authentication, rate limiting, and other security measures. The platform also includes analytics and reporting features, allowing developers to track usage and performance metrics for their APIs. 3scale API Management simplifies the process of managing and securing APIs, helping organizations to improve efficiency, reduce costs, and enhance the user experience.
There is two important terms in 3scale:
- Backend : Refers to the server-side infrastructure that powers an API. This includes the API endpoints, any databases or other services that the API relies on, and the backend code that processes requests and returns responses.
- Product : Refers to a set of related APIs that are grouped together and offered to developers as a single package. A product in 3scale can include one or more APIs, and can have its own authentication and usage policies, rate limits, and analytics. 3scale provides tools for managing and monitoring the performance of each product, and for customizing the developer portal and documentation for each product.

## How to use 3Scale to manage our api:

### platform setup:

  Go to [3scale.net](https://www.3scale.net/signup) and create an account with the desired subdomain.
  ![3scale singup](https://iou4.github.io/hosted_assets/images/3scale_singup.png)

  Verify your email and access the dashboard

### hosting the api:

3scale can't access localhost, so the api must hosted somehow, here we used a free tool called [Serveo](http://serveo.net/) which uses ssh to forward http traffic to a local port.

To host the api:
  - make sure all the services are up and running, and the api is accessible at port 8082.
  - make sure you have `Openssh` on your machine.
  - run
    ```bash
    $ ssh -R eai-api:80:localhost:8082 serveo.net
    ```

  Example: ![serveo.png](https://iou4.github.io/hosted_assets/images/serveo.png)


### Registering the api:

Now go to your 3scale dashboard, from the drop-down in the header choose 'backends'.
![backends](https://iou4.github.io/hosted_assets/images/backends.png)

Click on create backend and fill the fields with the desired name, system_name and description, the last field should be the link to the api in our case it is `https://eai-api.serveo.net:443`

Submit information by clicking create backend.
  ![create_backend](https://iou4.github.io/hosted_assets/images/create_backend.png)

### Adding methods and map them:

In 3scale API Management, a method refers to a specific operation or action that can be performed on an API resource after being mapped to a path.

to add a method :
  - make sure you're in the created backend page and click 'Methods and Metrics':
  ![add_method](https://iou4.github.io/hosted_assets/images/add_method.png)
  ![method](https://iou4.github.io/hosted_assets/images/method.png)
  - then add a mapping rule for the newly created method by clicking 'add mapping rule':
  ![create_mapping](https://iou4.github.io/hosted_assets/images/create_mapping.png)
  choose the desired path for the method which should be identical to the one provided by the api
  ![mapping](https://iou4.github.io/hosted_assets/images/mapping.png)
  now we should see the mapping
  ![success_mapping](https://iou4.github.io/hosted_assets/images/mapping_list.png)

### Adding the backend to the product:

In 3scale API Management, a product is a collection of one or more backends that are grouped together and offered to developers as a single package.

to add the backend:
  - navigate to the product:
  ![product_list](https://iou4.github.io/hosted_assets/images/product_list.png)
  - goto navigation->backends from side menu and click 'add backend':
  ![product_backends](https://iou4.github.io/hosted_assets/images/product_backens.png)
  - from drop-down menu choose the created backend and choose a path to be used as prefix for accessing the backend resources, meaning if we want to fetch '/api/virements' from the api and have '/x' as prefix in 3scale  we should request '/x/api/virements'. click 'add to product'
  ![add_backend_to_product](https://iou4.github.io/hosted_assets/images/add_product_backend.png)


### Submitting changes:

3Scale offers a stagin mechanisme to test changes before promote them to production.
In product dashboard go to integration >> configuration (should have a warn sign)
  - to stage click promote to staging, after this you can use the provided url to test everything before promoting to production.
  ![3scale_stagin](https://iou4.github.io/hosted_assets/images/3scale_stagin.png)
  - to promote to production click 'promote v.x to Production APIcast' and use the prodution url to access the resources.
  ![3scale_production](https://iou4.github.io/hosted_assets/images/3scale_production.png)

## Using RH-SSO to secure access to the api:
3Scale Api management support multipe authorization methods, to secure access to the product. we're intersted in RH-SSO:
 - In product dashboard go to integration >> settings >> Authentication and choose 'OpenID Connect', in OpenID Connect Issuer Type choose 'Red Hat Single Sign On',
 get the Issuer url from RH-SSO instance. then grant Authorization code flow, now at the very bottom click 'update product' then commit changes in configuration menu.
 ![3scale_rhsso](https://iou4.github.io/hosted_assets/images/3scale_rhsso.png)

## Testing:

Follow [RHSSO.md]() to setup and rhsso.
#### getting access token:

make a post request (with -form-urlencoded contentype) to rhsso's token endpoint which is in our case `https://eai-rhsso.serveo.net/auth/realms/eai-poc/protocol/openid-connect/token` with
- `grant_type=client_credentials`
- `client_id=<<you're client id>>`
- `client_secret=<<you're client secret>>`
- `scope=openid`

you should be grtting a ok json response with access token in it.

exmaple:
![token_success](https://iou4.github.io/hosted_assets/images/success_token.png)

#### accessing api:

with the access token available for us we can use it to authrize our access to 3scale, just use it in request header as a Bearer token.
exmaple:
![api_success](https://iou4.github.io/hosted_assets/images/success_api.png)

