# README

Prerequisites

* Ruby version: 2.5.0

* Rails version: 5.2.0

* Database Used: Postgres (both development and production)

  * Setting up postgres
    * create role myapp with createdb login password 'password1';
   


Clone/Download

* bundle install

* rails db:setup (though this will load the seed as well, but you can run rake db:seed, just in case)

* rails s

* Run: gem pristine --all

* https://gist.github.com/dhoelzgen/cd7126b8652229d32eb4



Setting up auto generation of uuid in psql
* add superuser permission to the postgres user 'gdgapp'


