#YelpCamp

*Add Landing Page
*Add CampGrounds Page that lists all campground

Each Campground has
*Name
*Image

<img src = "<%= campground.image%>"> because <%=%> just show like a string without quotes

#Layout and Basic Styling
* Create our header and footer partials
* Add in Bootstrap
*
#Creating New Campgrounds
*Setup new campground POST route
*Add in body-parser
*Setup route to show form
*Add basic unstyled form

#Style the campgrounds page
*Add a better header/title
*Make campgrounds display in a grid

#Style the Navbar and Form
*Add Navbar to all templates
*Style the new campground form

#Add Mongoose
*Install and Configure mongoose
*Setup campground model
*Use campground model inside of our routes

#Show Page
*Review the RESTful routes we've seen so far
*Add description to our campground model
*Show db.collection.drop()
*Add a show route/template

#Refactor Mongoose Code
*Create a models directory
*Use module.exports
*Require everything correctly

#Add Seeds file
*Add a seeds.js file
*Run the seeds file every time the server starts

#Add the Comment model
*Make our errors go away
*Display comments on campground show page

#Comment New/Create
*Discuss nested routes
*Add the comment new and create routes
*Add the new comment form

#Style show page
*Add sidebar to show page
*Dispay comments nicely

#Finish styling Show page
*Add public directory
*Add custom stylesheet

RESTFUL ROUTEs

name             url               verb            desc.
=========================================================
INDEX            /dogs             GET             Display a list of all dog
NEW              /dogs/new         GET             Display form to make a new dog
CREATE           /dogs             POST            Add new dog to DB
SHOW             /dogs/:id         GET             Shows info about one dog

INDEX     /campgrounds
NEW       /campgrounds/new
CREATE    /campgrounds
SHOW      /campgrounds/:id

NEW       /campgrounds/:id/comments/new    GET
CREATE    /campgrounds/:id/comments        POST
