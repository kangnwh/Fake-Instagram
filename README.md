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

