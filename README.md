# Application(IOS) of Mobile Assignment 2

This is the app part (IOS Swift) of Fake Instagram. This should be used together with [the backend part] (https://github.com/kangnwh/Fake-Instagram-Backend).



## Demo

YouTube Link: https://youtu.be/xIZUexAuOMY




## How to setup environment

### Preparation

#### Install Xcode 
Xcode 略



#### Install CocoaPods:

https://cocoapods.org



### Clone code

Clone code to your own computer
```shell
cd <your_project_folder>
git clone git@github.com:kangnwh/Fake-Instagram.git
```

### Install/Update 3rd packages
```shell
cd $Project_Folder
pod install # for first time installation of 3rd packages
pod update  # if Podfile changes

```



### Modify the server IP to your server

open `$iosapp_dir/SNSApp/CommonFuncs/WebAPIHandler.swift` update `line 21` to use your own IP address (which may be 127.0.0.1).

## Functionalities

- [x] Errors are treated correctly
- [x] Register and login screen
- [x] Functional Tab Bar at the bottom of screen
- [x] Scroll through photos and comments
- [x] Like a photo and display users who like a photo in the feed
- [x] Leave a comment
- [x] Sort by both date/time and location
- [x] Search for Users
- [x] Display suggested users to follow
- [x] Algorithm to suggest users
- [x] Take a photo with camera while providing flash options
- [x] Overlay a grid on top of camera view
- [x] Select photo from library instead of taking a new one
- [x] Change brightness and contrast
- [x] Crop a photo
- [x] Apply at least 3 different filters
- [x] Upload photo
- [x] Display users following that liked photos or started following user
- [x] Display activity of users that current user are following
- [x] Display stats on posts, followers and following, profile pic
- [x] Display all user photos uploaded
- [x] In Range Swiping, e.g. Swipe photos to friends nearby that they can view on feed with an "In Range" tag
- [x] Implement a server for communications or retrieve data from actual Instagram API


## Controbutors

- [ningk1, ningk1@student.unimelb.edu.au]
- [xlyu2, xlyu2@student.unimelb.edu.au]
- [nianl, nianl@student.unimelb.edu.au]
- [xwu11, xwu11@student.unimelb.edu.au] 

