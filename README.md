# Cinemax
![mockup](assets/mockup.png)

# Overview 
This is a massive movie app written with flutter and dart language. The app is written from scratch and supports pocketbase as backend service to fetch multiple categories of data in the appliction and all of the functionality of the application from fetching data to query in the list of movies and series has been handled with bloc state management. Includes `+50 Movies`, `+15 Series`, `A detailed list of upcoming movies and series`, `News`, `+10 Categories`, `Banners`, `Posting, Fetching, Deleting and updating comments ablity`, `watching trailer of the specific movie or series`, `ablity to download trailers` and `1 theme`. Users are able to sign up or login to their account and choose a profile picture for themselves if they wish to. Users are also able to save any particular movie or series and even upcomings to their wishlist, The wishlist is made up with an in-app NoSQL database called `Hive`. Application also supports `11 Different languages`. App is also able to send users notifications with firebase messaging to route them into the application.

# Features

- **Main Activity**: This app is designed in a way that user can look for differnt movies or series, watch their trailers and can post comment on them is he/she wishes to. This helps them find specific movie or series they are looking for.
- **Movie Detail**: Each movie is desgined to have 1 trailer, User can download that trailer, Can read about storyline, checkout the gallery of that movie, Cast and crew, Rate, Category, Timelength, Release Date, Comments and can add it to wishlist.
- **Series Detail**: Series detail is also frought with all movie detail ablities and also has a section that showcases each season episodes, thier synopsis, their rate and their picture too.
- **Download ablity**: User is able to download each movie or series trailer with their head name on it.
- **Share ablity**: This feature will be added in the furthur realses.
- **Search ablity**: User can search for different movie or series and also actors. Note that actor page will be added in the future.
- **Upcomings and Upcoming Detail**: this section will show what movies are on demand and upcoming. Each upcoming movie contains trailer, Synopsis, Cast, Gallery, Release Date, Category and can be added to wishlist.
- **News**: Movie news from all over the world is also covered. Each news has a release date, Title, Description and thier publisher.
- **Comments**: Users are able to post comment and can rate, Add title, description, Say if the comment has spoiler or not, Delete and Modify their comments in the settings screen.
- **Theme**: App also supports 1 theme which is the main theme and other visual themes will be added in the future release.
- **Language**: App supports 11 languages with flutter localization and user can choose one.
- **Credentials**: User has to sign up or login to app, Can pic a profile picture, Register phone number, can Delete that profile and modify the name.
- **Wishlist**: User's liked movie, series or upcoming will be added here with rate, name , trailer and can be removed.
- **App Start**: App will automatically check whether if user has internet or not and will launch it when they have internet.


# Dependancies
  - flutter_localizations
  - intl
  - shimmer
  - pinput
  - flutter_svg
  - smooth_page_indicator
  - persistent_bottom_nav_bar
  - lottie
  - get_it
  - flutter_bloc
  - equatable
  - dartz
  - dio
  - loading_indicator
  - cached_network_image
  - shared_preferences
  - hive_flutter
  - hive
  - dropdown_button2
  - connectivity_plus
  - image_picker
  - path_provider
  - flutter_rating_bar
  - font_awesome_flutter
  - url_launcher
  - video_player
  - flick_video_player
  - flutter_file_downloader
  - firebase_core
  - firebase_messaging
