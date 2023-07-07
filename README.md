# StoreLabTechnicalTask

A simple iOS app that allows users to scroll the unlimited images

The master view shows a list of Images. Select an Image to like the Image.

The Favorite pictures liked status are saved locally to keep the state of the like button 

## System Requirements

* Xcode 14.0+ for iOS version 
* iOS 14+
* macOS 13+

## Search Movies

Type in search bar to search for movies


### iOS

Tap the movie tile to view full detail of each movies


## Interesting Files

* The `ImageListViewController.swift` and `MovieViewModel.swift` files have all the controlling logic of list of images.
* The `ImageDetailsViewController.swift` and `Movie.swift` files have the code for details of each images.
* The `ImageDetailTableViewCell.swift` and `Movies.swift` files have the code for what is displaying what is on the tile.
* The `FavoriteImagesViewController.swift` and `Movies.swift` files have the code for displaying favorite images.

## Package Dependencies (Used Swift Package Manager)

* https://github.com/realm/realm-swift
* https://github.com/SnapKit/SnapKit
* https://github.com/onevcat/Kingfisher.git

## Description On my Decisions
* I used MVVM achitectural pattern because, i am very familiar with it and its easier to write clean, readable, maintainable code and isolate each functionality. It was a bit hard because it gets complex when setting up the code base but, using dependency injection makes it easier to achieve my goal.
* I wanted go with the Best UI Practise so i made sure the UI is Purposeful and easy to use. I had help from my wife to use the app and give me feedback on noticable bugs that i fixed.

## Future Improvement 
* I will add login functionality to make it possible for different users to have there profile and list of favorite images

## Screen Shot
![IMG_78649A3DBC23-1](https://github.com/oluwatobiHammed/StoreLabTechnicalTask/assets/50711478/2f620de0-8f01-4da5-8173-8213ec73e628)
![IMG_16A282D59391-1](https://github.com/oluwatobiHammed/StoreLabTechnicalTask/assets/50711478/346eed76-51f8-47d9-9c6f-b2b759710324)

