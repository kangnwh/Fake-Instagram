# Application(IOS) of Mobile Assignment 2

- Using pod for package management


## How to setup environment

### Preparation

#### Setup your ssh key in visualstudio team service (if your did not do it before)
1. Ensure your computer installed git tool
> For windows, install [here](https://gitforwindows.org) if not

> For Mac/Linux, your computer may already has, just try command `git`

2. Generate your ssh key if you konw command well( Mac or Linux)
> check [here](https://confluence.atlassian.com/bitbucketserver/creating-ssh-keys-776639788.html)

3. Add your public key into our project
```shell
cat ~/.ssh/id_rsa.pub
```

- Open web : [https://kangnwh.visualstudio.com/_details/security/keys](https://kangnwh.visualstudio.com/_details/security/keys)
- Add the content in your `id_rsa.pub`

#### Install Xcode and Pod
略....

### Clone code

Clone code to your own computer
```shell
cd <your_project_folder>
git clone kangnwh@vs-ssh.visualstudio.com:v3/kangnwh/SNSApp/SNSApp
```

### Install/Update 3rd packages
```shell
cd $Project_Folder
pod install # for first time installation of 3rd packages
pod update  # if Podfile changes

```

#### workplace 
Open [this](https://kangnwh.visualstudio.com/SNSApp/SNSApp%20Team/_dashboards/SNSApp%20Team/df984ad3-1ac5-48f8-a201-35c3e1f8b705) for our project dashboard

