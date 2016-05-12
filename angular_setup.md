# Angular Setup
We will now transition our Reddit clone from a Rails app rendered on the server side to a Single Page App (SPA) 
rendered on the client side.

Some of these instructions are intentionally incomplete because I want you to figure things out on your own. For instance, **Generate a new controller. I called mine `angular`**, if you don't remember how to generate a controller in rails, Google for it.

## Angular transformation strategy
Whenever you create angular code refer back to Codecademy Learn AngularJS. One strategy is to copy/paste existing code 
as a starting point. 

If you need to create a new angular route, look at the routing section. If you need to create a new directive, look at the directive section.

## Goal
The goal for these instructions is to create two pages using angular:

1. The root page that shows a list of Channels. The Channel title should be a link to the Channel *show* angular page
![Angular Root](./angular-root.png?raw=true "Optional Title")

2. A Channel *show* page that shows a single Channel.

![Angular Show](./channel-show.png?raw=true "Optional Title")
 

## Create Rails Controller
- Generate a new Rails controller. I called mine `angular`
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

This is what the angular directory should look like when you finish this guide

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
- In `js` create a file called `app.js`
- In `js/controllers` create a file called `MainController.js`
- in `views` create a new file called `main.html`

## Update index.html.erb
*Do not use any `erb` statements in this view.*

To run your angular application code, you need to include it using `<script>` tags in `index.html.erb`. See examples from `index.html` on codecademy.

You also need a little HTML to bootstrap the view.
```html
<div ng-app="myApp"> <!-- Use you're app name -->
  <div ng-view></div>
</div>
```

## Inside app.js
- Create a new app with `ngRoute` dependency.
- I called mine `myApp` 

#### Configure Headers for $http
```javascript
app.config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.headers.common['Accept'] = 'application/json';
  $httpProvider.defaults.headers.common['Content-type'] = 'application/json';
}]);
```

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
  
  return {
    channels: channels
  };
  ...
```

## Add angular Controllers
- Create an angular controller to handle your root page. 
  - I called mine `MainController`
  - The root page shows a list of channels so this controller needs to get the list of all channels using the `resources` service
- Create an angular controller to show a single Channel. 
  - I called mine `ChannelController`
  - You need to create a new file for this controller in `/app/assets/javascripts/anguar/js/controllers`
  - The controller will need to look up a channel given an `id` param using the `resources` service.

## Create Channel directive
In web 2.5 and beyond most frameworks offer the ability to create custom html elements or *web components*. In angular, these components are called diretives. They give you the ability to create your own html tags like: `<channel></channel>` 

#### Create a custom directive to dispalay a channel.
- I called mine `channel` 
- The javascript and html files go in the `/app/assets/javscripts/angular/js/directives` directory
- Refer to codecademy's section on directives. 
- Remeber that the channel's title needs to be a link to the channel show page.

## Add angular views 
You will need to create views for the root page and the channels *show* page

#### Root page view
The root page view will use the `<channel>` directive to display a list of channels. 

Hints:
- Use the `views/main.html` file you crated earlier
- You need to wire up the controller using `ng-controller`
- You will loop through all of the channels provided by the controller using `ng-repeat`

#### Channel show view
The root page will use the `channel` directive to display a single channel

Hint:
- Create a new HTML file: `/app/assets/javscripts/angular/views/channel.html` 
- You need to wire up the controller using `ng-controller`

## Add Angular routes
We are transitioning our Reddit clone from Web 2.0 to web 2.5 which means that the client side is responsible for routing and template rendering.

- Add an angular route to handle the angular root url `/angular`
 - The controller for this route is your main controller
 - The templateUrl for this route is your main view
- Add an angular route to show one Channel `/angular/channels/5`
   - The controller for this route is your channel show controller
   - The templateUrl for this route is your channel show view


