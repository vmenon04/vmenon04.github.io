---
layout: page
title: Stargazr
date: 2024-06-01
excerpt: A modern stargazing assistant that provides personalized recommendations for the best nights to stargaze, combining astronomy, weather, and light pollution data.
links:
  website: https://stargazr.org
  github: https://github.com/vmenon04/darksky
---

## Overview
Stargazr is a modern stargazing assistant that analyzes your location and provides personalized recommendations for the best nights to stargaze, factoring in astronomical, weather, and light pollution data. Built with a FastAPI backend and deployed via Vercel, the project combines real-time weather APIs, astronomy calculations, and Bortle scale estimations for global usability.

## Key Features
- **Astronomical Forecasting:** Calculates moon phase, rise/set times, and visibility scores for the next 7–14 days.
- **Weather Integration:** Uses OpenWeatherMap and caching to deliver accurate, location-based forecast scoring.
- **Dark Sky Zones:** Recommends the best nearby dark sky zones using distance heuristics and a curated JSON database.
- **Security & Rate Limiting:** Enforced CORS, CSP headers, request validation, and per-IP limits using SlowAPI.
- **Real-Time Light Pollution Estimation:** Scrapes Bortle scale values via ClearOutside, with fallback geospatial estimates when unavailable.

## Backend Architecture
The FastAPI backend is secured via **TrustedHostMiddleware**, **rate limiting**, and **security header enforcement**. API endpoints support location-based queries for recommendations, forecast retrieval, and dark sky exploration. The backend pipeline includes weather caching, moonlight-aware visibility scoring, and client-side safety via request filtering and logging for suspicious behavior.
