TEMPO
===
## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)

## Overview
### Description
A music app that allows a user to log in through Spotify, allows the user to input several users, combines those several users' tastes into one playlist, and adds that playlist to the user's account. 

### App Walkthough GIF

<img src="gif.gif" width=250><br>

### App Evaluation
- **Category:**
Music/Social Networking
- **Mobile:**
This app will be primarily developed for mobile use, but its functionality isn't limited to mobile devices.
- **Story:**
Analyzes the music tastes of usernames given, and creates a playlist combining the preferences of all those users.
- **Market:**
Any individual could use this app; it would be beneficial for groups of people to have a playlist they all would enjoy.
- **Habit:**
This app could be used as often as the user wants with several playlists for different groups of people they spend time with or listen to music with. 
- **Scope:**
First we are starting with producing a playlist that takes into account everyone's preferences, but later this could evolve into something that also takes into account a specific mood for the setting and attunes the songs in the playlist to accomodate the requested mood. Large potential for use with spotify, and other music sharing apps. 


## Wireframes
<img src="wirefrane.png" width=600>


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can log in to Spotify through the Tempo app. 
* User can input Spotify usernames to a text field and press enter. 
* User gets a playlist of 25 songs that combines their tastes using each user's playlists. 
* The customized playlist is added to the account the user logged in with. 

**Optional Nice-to-have Stories**

* User can add theme and customized playlist considers danceability of songs to match theme.
* User can play songs on the customized playlist through Spotify from the Tempo app. 
* The customized playlist contains 100 songs.

### 2. Screen Archetypes

* [Login/Register]
   * [User can log into Spotify account]
   * ...
* [Stream]
   * [User can scroll through previously created playlists]
   * ...
* [Detail]
   * [User can view details of a created playlist]
   * ...
* [Creation]
   * [User can create a new playlist]
   * ...
* [Profile]
   * [User can scroll through previously created playlists]
   * [User can customize settings]
* [Settings]
   * [User can change theme ]
   * [User can change the number of songs per playlist]

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Settings]
* [Home]

**Flow Navigation** (Screen to Screen)

* [Loading Screen]
   * [Loading Screen --> Login Page]
   * ...
* [Login Page]
   * [LoginButton --> Spotify Login]
   * [SignUpButton --> Create Login Page]
* [Spotify Screen]
   * [--> Profile Screen]
   * [BackButton --> Login Page]
* [Create login]
   * [SignUpButton --> Profile Screen]
* [Profile Screen]
   * [onTapofPlaylist --> Playlist Screen]
   * [onTapCreateButton --> Creation page]
* [Playlist screen]
   * [toProfilebutton --> Profile Screen]
* [Creation screen]
   * [OnTapCreate Playlist --> Playlist Screen]
   * [BackButton --> ProfileScreen]
