# README

This is a simple application where you type in an address and it returns the longitude and latitude coordinates of the address using [Google's API](https://developers.google.com/maps/documentation/geocoding/intro). We store these results in a database and display them at the bottom of the page.

The functionality is simple and I wanted the user experience to be simple as well. I decided to allow users to enter the address in a single input field rather than filling out a form specifying Street, City, State, Country, etc... This makes it easier to copy and paste addresses to get the coordinates. 

This also makes it harder to validate user's input and make sure they are entering a valid address. I decided to let Google handle address validation, and raise an error if it returned zero results. An interesting thing I learned while doing this approach is that the Google API will geocode a lot of stuff that are not addresses using what it calls a "partial match". I'm not sure exactly how it works, but the word "test" maps to an address in Oregon. The API will return zero results if you enter something that resembles a valid address that doesn't exist. For example, "123 Nowheresville" always returns zero results.

Every query submitted by a user is stored in the database to minimize the number of times we need to hit the API. After every request, the app first checks the database to see if it has geocoded this query before, and if it has returns the result from the database. If it hasn't we ping the Google API to try and get the coordinates, and regardless if it is a successful request or not, the query gets stored in the database.

Some additional features I would like to add in the future are the ability to sort by table columns at the bottom of the page to make it easier to see if the address has already been geocoded. I would also like to add pagination to prevent the table from getting too big as more adddreses are added.
