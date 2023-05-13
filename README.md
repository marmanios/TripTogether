# TripTogether

Trip together was an application built in a short amount of time aiming to satisfy the following requirements.

Create an app which allows users utilizing a fictional taxi service to offer their taxis as carpools. Users
should be able to scan a QR Code (or some other kind of code) and enter in their carpool details for carpool requesters
to see. Once a requester sends a request to join a carpool, the offerer is given a prompt to accept or decline their request.
As more users join the carpool, the route is updated and the fair price is recalculated and distributed amongst all passengers.

## How to run

- Configure your firebase account to this app using flutturefire configure
- Create a .env file with these variables for 
spotify API integration (optional)
- 1. CLIENT_ID
- 2. REDIRECT_URL
Google maps API integration (mandatory)=
- 3. MAPS_API_KEY

## What can trip together do?

- Built in about 2 days for a project, trip together has the following features
- 1. Fully intergrated firebase authentication with error handling. Upon signing up, users also have an entry created in the firebase database to hold additional information regarding trip data
- 2. Scan QR codes. This is to be used to scan your (hypothetical) drivers QR code 
- 3. Autocomplete location searches using the google maps API
- 4. Pair carpool offerers with carpool requesters using firebase's realtime database 
- 5. Display a notification to the offerer in realtime when a user requests to join their carpool and a notification back to the user if they were accepted or rejected.
- 6. Display your location on a map within the map alongside the status off all other users and the total trip fare which decreases as more users join the carpool