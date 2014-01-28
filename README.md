# AUCTION APP #

Welcome the the git repository for "Auction App" built by Robert j Chatfield (s2187099). This is a WIP project developed for 2503ICT Web Programming Summer Semester Intensive at Griffith University.

**COURSE**: 2503ICT
**NAME**: ROBERT CHATFIELD
**STUDENT NUMBER**: S2187099
**DATE**: TUESDAY, 28TH JANUARY


## SETUP

    $ git clone git@bitbucket.org:rjchatfield/auction-app.git
    $ cd auction_app
    $ bundle install
    $ rake db:reset; rake db:populate
    $ rails s
    $ open http://localhost:3000/        # in new Terminal tab


## SAMPLE DATA GENERATION

    $ rake db:reset; rake db:populate

This function will:
+ Create the database (if there is none present)
+ Purge any data (if there already was a db present)
+ Populate it using a script in /auction_app/lib/tasks/sample_data.rake


## USAGE

Navigation Bar bar items are as follows.

`Buy`:   Will take you to the items#index with the search feature
`Sell`:  Will take you to the items#new
`Admin`: Will take you to the categories#index. This is not protected with any authentication.


## FEATURES NOT IMPLEMENTEND

All features were implemented as per the assignment specification provided Sunday, 26th January.


## ADDITIONAL FEATURES IMPLEMENTED

* Categories filter can be triggered by clicking on the category in items#index or items#show.
* Pagination of items#index
* Fancy CSS hover of debug information while in Rails Development. Try hovering over the bottom of any HTML page to see the debug information. This 'reveal on hover' technique helped with UI development (without being too distracting).
* Page Titles and H1's are programmatically appended with assignable instance variables. Additionally, "[ADMIN]" has been programmatically prepended to all Category views.
* Restriction prohibits the Admin from destroying a Category that contains Items.


## USABILITY TESTING

Many hours of developer testing was completed during production of this application. This included continual testing across browsers such as Apple Safari, Mozilla Firefox and Google Chrome.

Additionally, my father also participated in an informal testing and feedback session. I briefed my father of the core features of the application, what it was aiming to do and what was outside of the scope of this assignment.

> **Feedback**
It was impressive overall, however he found it confusing to get back to the main page.
**Changes**
While there was always a link on every page (provided in the header), it was apparent that it wasn't the obvious way "home". To rectify this, I improved the colour scheme and styling in the main CSS file.


## ISSUES

Any issues and bugs can be reported to s2187099@griffithuni.edu.au.


## THANK YOU
