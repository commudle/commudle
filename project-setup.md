#Project Setup Setups (Development Mode)


###Prerequisites
* Ruby version: 2.5.0
* Rails version: 5.2.0
* Database Used: Postgres (for both development and production)
  * Set up postgres
    * Login to postgres and create a superuser  **(we need it because we're enabling a couple of extensions)**
      * `create role gdgapp with createdb login password ==your-password==;`
    


###Clone/Download
* `bundle install --deployment`
* `rails db:setup` (though this will load the seed as well, but you can run rake db:seed, just in case)
* `rails active_storage:install`
* `rails db:setup`

###Run the Server
* `rails s`
* Run: `gem pristine --all`




