1. Install ruby (1.9.3)
2. `gem install bundler`
3. cd to the project directory.
4. `bundle install`
5. Install mysql server. (You can use sqlite too, however you'll need to make changes to the config/database.yml file, and then we'll have to use separate versions of that. Not worth the effort)
6. Create the database (dalalstreet_dev). Then run the dalalstreet.sql script (`mysql -uroot dalalstreet_dev < dalalstreet.sql`)
7. Make apt connection settings in database.yml (username, password etc)
8. From project home directory, run `rails server`.

This should do for most of the stuff. You *might* need to install redis. Not too sure how critical it is for the app to run.  
