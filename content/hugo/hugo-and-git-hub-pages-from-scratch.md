---
title: "Hugo and GitHub Pages from scratch, visible sources"
date: 2021-04-17T16:03:23+01:00
draft: false
tags: ["Hugo", "GitHub Pages"]
---
## Create a new Github Pages site based on Hugo

Creating a new GitHub Pages site based on Hugo, and following this page, assumes
* A GitHub account exists
* Hugo is installed
* Git is installed
* A DNS tool is available to set the custom domain

## Create local website
cd above-project, and
```
websites> hugo new site workout
```

## Add a theme
* Download the zip from https://github.com/Vimux/mainroad
* Inside there is a single folder. Copy it to ...\workout\themes
* You will get someting like ...\workout\themes\Mainroad-master
* Rename folder "Mainroad-master" to "mainroad"

## Change to the website folder.
All commands will happen here, from now on
```
websites> cd workout
websites\workout>
```

## Tell Hugo that you are using the Mainroad theme
```
websites\workout> echo theme = "mainroad" >> config.toml
```

## Tell hugo to publish in a "docs" folder
By default site would be published to "public".
This will be required by GitHug pages, ahead
```
websites\workout> echo publishDir = "docs" >> config.toml
```

## Set your custom URL as basepath
Edit file config.toml in the website folder
Change
```
baseURL = "http://example.org/"
```
to
```
baseURL = "http://your.custom.url.com/"
```

## Create a first post
```
websites\workout> hugo new blog\hello.md
```
Edit content\blog\hello.md, put some text there
Inside the file, remember to change
```
draft: false
into
draft: true
```
This depends you the theme you are using

## Test locally
```
websites\workout> hugo server -D
```
Open your browser, go to http://localhost:1313
When you are done, stop the local server with Ctrl+C

## Publish site to the "docs" folder
```
websites\workout> hugo
```

## Greate repository workout
In Github, create a repository named workout
do not "Initialize this repository with a README"

## Create a Git repository
Create a local Git repository and sync with the GitHub project
```
websites\workout> git init
websites\workout> git add .
websites\workout> git commit -m "first commit"
websites\workout> git remote add origin https://github.com/apalhinha/workout.git
websites\workout> git push -u origin master
```

## Activate GitHub Pages
In Github -> settings -> GitHub Pages
Source = Master Branch / docs Folder
Custom domain = workout.mycontributes.online

## Set DNS settings if not done yet
Access your DNS manager and add a CNAME
* Name = yoursite.yourdomain.com
* alias = yourgithubname.github.io

## Github settings are changed the remote repository.
Bring those changes to the local copy
```
workout\public> git pull origin
```

## Now change your website
Use your favorite editor.
Update pages under "content" folder

When you want to see, check in the local machine
```
workout> hugo server -D (include pages flagged as draft)
or
workout> hugo server    (drafts are kept away, same that will be published)
```

## Happy? Publish
When happy with the new content, publish, commit to git, and push to the remote repository
```
workout\public> hugo
workout\public> git add .
workout\public> git commit -m "commit"
workout\public> git push origin master
```

Sometimes it takes a few minutes for GitHub Pages to display the updated content
