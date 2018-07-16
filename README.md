##### Learning Application
Learning app is a ruby Application that allows users to learn new stories every day based on their user preferences

###### Installation and Setup
To use Learning app locally:
 - Clone the app by running `$ git clone https://github.com/geeeh/learning-app.git`
 - Get into the project root folder `$ cd learning-app`
 - Install dependencies `$ bundle install`
 - Run app `$ thin`

 ###### Currently working endpoints

 Endpoint | purpose
--- | --- 
GET / | directs user to landing page
GET /login | directs user to login page
GET /register | directs user to registration page
POST /login | user authentication
POST /register | create new user
GET '/categories' | head to categories page
GET '/addcategories' | page to add categories for admin
POST '/categories', | create a new category
POST '/categories/add', Add your prefered categories
GET '/topics'| get daily topics

###### Already done features
- user authentication
- landing page
- categories page
- Daily digest page
- Email notifications

###### contributers
- Godwin Gitonga
