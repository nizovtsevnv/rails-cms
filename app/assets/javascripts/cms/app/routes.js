addEventListener('load',function(event){
  // Application routes
  Router.routes  = {
    login: {path: 'login', controller: SessionsController, action: 'login'},
    root: {path: '', controller: DashboardsController, action: 'main', constraints:{name: '[^\/]*'}}
  }

  Router.exception = function(route){
    ErrorsController.page_not_found({route: route})
  }
  
  // Start the application  
  addEventListener('hashchange', Router.run)
  Router.run()
})
