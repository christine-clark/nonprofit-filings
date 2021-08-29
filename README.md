# README

## Overview
This project will read and parse through XML files which will generate filer, receivers, and awards for US non-profit organizations.


## Setup Database
Setup a PostgreSQL user account and database locally. Currently, this project is only setup to run locally at this time.
- https://www.postgresql.org/docs/current/sql-createuser.html
- https://www.postgresql.org/docs/current/tutorial-createdb.html

Then edit the `.env.example` file to set your Postgres user and password.
```
export POSTGRES_USER=[youruser]
export POSTGRES_PASSWORD=[yourpassword]
```

Rename the `.env.example` file to `.env`

Once you have setup your database, you will need to create and run migrations.
Run the following commands:
```
rake db:setup
rake db:create
rake db:migrate
```

To populate your database with default information, run:
```
rake db:seed
```


## Install Dependencies and Run Server
Install all of your dependencies by running: 
```
bundle install
```

Run your rails server: 
```
rails s
```

With the server running, you can now access the API. There are two endpoints currently available:
```
http://localhost:3000/filers
http://localhost:3000/receivers
```

## Testing
To run all tests:
```
rspec spec
```

To run the specific test for the XML parser:
```
rspec ./spec/services/parsers/xml_tax_filing_spec.rb
```

*Note*: There is a known bug if `rake db:seed` was run before running all tests with `rspec spec`. This is due to the seed file creating more data than the test is checking for. In order to view a clean test run, then you will need to reset the database.

You can reset the database with the following command:
```
rake db:drop && rake db:create && rake db:migrate
rspec spec
```

## Future Improvements
- Push the site up to Heroku to make the APIs available online
- Fix the rspec tests!!!
  - There is currently a bug with the tests due to the seed file being run BEFORE running all tests.
  - This need to be adjusted to exclude seeded data during tests.
- Implement proper error handling which would track all failed record instances which were not inserted into the database. This would then get emailed to the user to send back an XML file of the failed results.