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

RESTFUL ROUTEs
//For Campgrounds
name             url               verb            desc.
=========================================================
INDEX            /campgrounds             GET             Display a list of all campgrounds
NEW              /campgrounds/new         GET             Display form to make a new campground
CREATE           /campgrounds             POST            Add new campground to DB
SHOW             /campgrounds/:id         GET             Shows info about one campground
//For Comments
NEW     /campgrounds/:id/comments/new     GET
CREATE  /campgrounds/:id/comments         POST

#Refactor Mongoose Code
*Create a models directory
*Use module.exports
*Require everthing correctly!

#Add Seeds file
*Add a seed.js file
*Run the seeds file every time the server starts

#Add the Comment model
*Display comments on a campground show page

#Comment New/Create
*Discuss nested routes
*Add the comment new and create routes
*Add the new comment form

#Style Show Page
*Add sidebar to show page
*Display comments nicely

#Finish Styling Show Page
*Add public directory
*Add custom stylesheet