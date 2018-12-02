# README

Prerequisites

* Ruby version: 2.5.0

* Rails version: 5.2.0

* Database Used: Postgres (both development and production)

  * Setting up postgres
    * create role kommunity with createdb login password 'password1';
    
* bundle install --deployment
   

Setup DB Backup
* gem install backup -v5.0.0.beta.1





Clone/Download

* bundle install

* rails db:setup (though this will load the seed as well, but you can run rake db:seed, just in case)

* rails active_storage:install

* rails db:migrate

* rails s

* Run: gem pristine --all

* https://gist.github.com/dhoelzgen/cd7126b8652229d32eb4



Setting up auto generation of uuid in psql
* add superuser permission to the postgres user 'gdgapp'


Defining User Permissions
* create a permission in role_permission.rb for each controller and user_role
* if the permission is conditional, that is, requires an object to check where it is owned by a user, pass that object into an thread_mattr_accessor by calling RolePermission.<object_name>


