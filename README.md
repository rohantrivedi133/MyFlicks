# Project 1 - *MyFlicks*

**MyFlicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **X** hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.
- [X] User can view movie details by tapping on a cell.
- [X] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [X] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [X] Customize the UI.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [X] Customize the navigation bar.

The following **additional** features are implemented:

- [X] Added Ratings of movies that change color based on review
- [X] Display release date of moives

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would like to discuss implementation of a status search bar
2. I would like to discuss the addition of network errors and animation
3. I would like to learn how to add a nagivation window before the page with a tabbar

## Video Walkthrough 

Here's the first walkthrough of implemented user stories:

<img src='http://i.imgur.com/0JMkbHZ.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Here's the second walkthorugh of implemented user stories:

<img src='http://imgur.com/kp21jvy.gif' title = 'Video Walkthrough 2' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

implementing the collection view was a little challanging due to creating a new set of code for the collection view. Additionaly attempting to work on implementing a search bar was a little difficult.

## License

    Copyright [2017] [Rohan Trivedi]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
