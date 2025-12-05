---
layout: page
title: Stargazr
date: 2025-06-13
excerpt: A modern stargazing assistant that provides personalized recommendations for the best nights to stargaze, combining astronomy, weather, and light pollution data.
links:
  website: https://stargazr.org
  github: https://github.com/vmenon04/darksky
---

I built this simple web-app to assist people in finding the right time and place to go stargazing. Users can view conditions for their current location or explore nearby designated dark sky zones, with each recommendation scored based on factors like cloud cover, moon brightness, humidity, and visibility to help identify the best nights for observing the stars.

Data for dark sky places was scraped from the [International Dark Sky Places](https://darksky.org/what-we-do/international-dark-sky-places/) (IDSP) program website, and weather data is taken from the [OpenWeatherMap API](https://openweathermap.org/api). The application calculates astronomical conditions including moon phases and illumination using PyEphem, fetches real-time Bortle scale measurements from [Clear Outside](https://clearoutside.com/) to determine light pollution levels, which is combined with the weather forecast data to provide stargazing recommendations. Most of the data is cached to prevent excessive API calls and reduce loading times. 
 

It was also featured on the [Light Pollution News Podcast](https://lightpollutionnews.com/podcast/why-its-so-bright-at-night-vasudev-menon/)!