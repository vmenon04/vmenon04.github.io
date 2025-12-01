---
layout: page
title: Visualize your Spotify Taste
date: 2025-02-10
excerpt: A web application that integrates with the Spotify API to analyze and visualize your music taste, featuring track analysis and abstract mosaic generation.
links:
  website: https://spotify-visualizer-blond.vercel.app/
  github: https://github.com/vmenon04/spotify-visualizer
---

## Overview
The "Spotify Visualizer" project is a web application that integrates with the Spotify API to analyze and visualize user data. The backend is built using FastAPI, a modern Python web framework known for its high performance and ease of use.

## Key Features
- **User Authentication:** Utilizes OAuth2 to authenticate users via their Spotify accounts.
- **Top Tracks Retrieval:** Fetches and displays the user's top tracks.
- **Taste Visualizer:** Analyzes saved tracks to provide insights based on track popularity and duration.
- **Mosaic Generation:** Creates an abstract mosaic image from album covers of saved tracks.

## Code Overview
The backend handles functionalities such as user authentication, token management, and data retrieval from the Spotify API. The frontend is built using Next.js and React, styled with TailwindCSS. It provides an interactive and responsive UI for visualizing Spotify data.
