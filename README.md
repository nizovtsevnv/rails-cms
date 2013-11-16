Rails CMS
---------

Installation
------------

1. Fork it.

2. Clone it to your local machine.

3. Install dependencies:

    bundle install

    rbenv rehash

4. Set a secret token for your app. Replace "CHANGE_ME" in ./config/initializers/secret_token.rb to a random string

5. Configure deployment files in ./config/deploy.rb and ./config/deploy/*

6. Insert an administrator account to database

7. Redesign and fill content to site

Test
----

We use automatic testing for creating one/two records of all factiories and for all RESTful actions in listed controllers.
Also we test rendering of page controller actions.
You can add all you need for testing of business logic.
