## SkyMind

SkyMind is a flutter-based mobile application developed for tracking weather forecast details of different locations including temperature, humidity and the wind speed.

## Features
*   Home screen with weather forecast summery
*   Search for weather forecasts by entering city name
*   View detailed forecasts with graph views and 5-day forecasts
*   Adding cities to the favourites list
*   View a list of all the favourites list
*   Delete favourite cities
*   Filter cities by region
*   Receive weather alerts for different cities
*   Change app design using settings

## How the App Works
*   The users are able search for cities and view their weather forecasts
*   Home screen will show a summery of weather details of the searched city
*   Forecast screen will display a detailed forecast of a selected city, including a graph to show 5-day forecast details
*   Users can add cities to their favourites list and remove them if needed
*   The filter by region screen will allow users to select a region from the dropdown menu and view the major cities located in a specific region
*   Users will be able to see the weather details by clicking a city in the favourite screen or the region filter screen
*   Users can change the app theme, change the displaying units of temperature and wind speed, and turn on or off weather alerts for cities by using the settings screen

## Technologies Used
*   Flutter & Dart
*   Riverpod for state management
*   SQLite (sqflite) for local data persistence (Favorites & Alerts)
*   Dio for API requests (OpenWeatherMap)
*   fl_chart for weather visualization
*   Workmanager & Flutter Local Notifications for background tasks
*   Git & GitHub for version control
