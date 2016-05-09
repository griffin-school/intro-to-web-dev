# Angular Setup
We will now transition our Reddit clone from a Rails app rendered on the server side to a Single Page App (SPA) 
rendered on the client side.

Some of these instructions are intentionally incomplete because I want you to figure things out on your own. For instance, **Generate a new controller. I called mine `angular`**, if you don't remember how to generate a controlle rin rails, Google for it.

## Goal
The goal to create two pages using angular:

1. The root page that shows a list of Channels. The Channel title should be a link to the Channel *show* angular page
![Angular Root](./angular-root.png?raw=true "Optional Title")

2. A Channel *show* page that shows a single Channel.

![Angular Show](./channel-show.png?raw=true "Optional Title")
 


## Create Rails Controller
- Generate a new controller. I called mine `angular`
- Add an empty method called `index`

## Create Rails View
Create a new file for the angular controller's index action `index.html.erb`

## Add a Rails route 
Add a route for the url `http://localhost:3000/angular` to the `index` method of your angular controller

## Add angular script tags 
Add these script tags to your application layout to include the AngularJS library on each of your pages
```html
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular-route.js"></script>
```

## Create angular file structure
All of the angular files are *static* HTML/JS files so they will live in the `assets/javascripts/` folder.

This is what the angular directory should look like

```
/app/assets/javascripts/angular
├── js
│   ├── app.js
│   ├── controllers
│   │   ├── ChannelController.js
│   │   └── MainController.js
│   ├── directives
│   │   ├── channel.html
│   │   └── channel.js
│   └── services
│       └── resources.js
└── views
    ├── channel.html
    └── main.html
```

- Create a new folder in `assets/javascripts` called `angular`
- Create two new folders in `angular`: `js` and `views`
- In `js` create three new folders: `: `controllers`, `directives`, `services`
- In `js` create a file called app.js
- In `js/controllers` create a file called `MainController.js`
- in 'views` create a new file called `main.html`

## Angular transformation strategy
Whenever you create angular code refer back to Codecademy Learn AngularJS. One strategy is to copy/paste existing code 
as a starting point. 

If you need to create a new angular route, look at the routing section. If you need to create a new directive, look at the directive section.

## Update index.html.erb
*Do not use any `erb` statements in this view.*

To run your angular application code, you need to include it in `index.html.erb`. See examples from `index.html` on codecademy.


## Inside app.js
- Create a new app with `ngRoute` dependency.

#### Configure Headers for $http
```javascript
app.config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.headers.common['Accept'] = 'application/json';
  $httpProvider.defaults.headers.common['Content-type'] = 'application/json';
}]);
```

- Create route for `/angular/` and default route to `/angular`

#### Pretty URL's
Angular was created before HTML5. It had to use a `#` in URL's to do custom routing. Add this to your app config if you 
don't want `#`'s in your URL's.
```javascript
// use the HTML5 History API
$locationProvider.html5Mode({
  enabled: true,
  requireBase: false
});
```

## Create resources service
The angular app needs to post and fetch data from your Rails server. The code for this will live in a service called `resources`
- Create a new service called `resources`
- Create a function to `all` that uses `$http` to get all of the Channels.

#### Example
```javascript
  ...
  // Reference codecademy Create Service section
  var channels = {};
  channels.all = function() {
    return $http.get('/channels')
            .success(function(data) {
              return data;
            })
            .error(function(err) {
              return err;
            });

  }
  ...
```

- Create a function called `show` that uses `$http` to get a single Channel.

#### Example
```javascript
  ...
  // Reference codecademy Create Service section
  channels.show = function(id) {
    return $http.get('/channels/' + id)
            .success(function(data) {
              return data;
            })
            .error(function(err) {
              return err;
            });
  };
  ...
```

## Add Angular routes
We are transitioning our Reddit clone from Web 2.0 to web 2.5 which means that the client side is responsible for routing and template rendering.

- Add an angular route to handle the angular root url `/angular`
- Add an angular route to show one Channel `/angular/channels/5`


