---
title: "Git and GitHub, from scratch"
date: 2021-04-17T16:03:23+01:00
draft: false
tags: ["Git", "GitHub"]
---
## Creat a Github repository
* Do this in the Github interface
* do not "Initialize this repository with a README"

## Create a Git repository


```
git init
git add .
git commit -m "first commit"
```

## Link the local folder with a Github project

```
git remote add origin https://github.com/github-user/github-project.git
git push -u origin master
```

## Commit locally, push to Github
Do this after changing files

```
git add .
git commit -m "commit"
git push origin master
```

## Create and activate an hotfix branch

```
git branch a_hotfix    # create branch
git checkout a_hotfix  # activate branch
```

(do changes in the branch)

```
git add .
git commit -m 'this works'
```

## Merge hot fix in the master

```
git checkout master    # activate master
git merge a_hotfix     # merge changes made in a_hotfix
```

## Delete unneeded branches (merger or not)

```
git branch -d a_hotfix # Delete the branch
```

## Listing commands

```
git log --decorate  # see (some) branches
git log --all --decorate # See all branches
git log --oneline --decorate --graph --all  # nicer format
```

## See what can be undone, or undone one file
```
git checkout --        # See what is available to undo
git checkout filename  # Undo changes in the filename

```
