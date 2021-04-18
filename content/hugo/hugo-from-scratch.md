---
title: "Hugo from scratch, GitHub Pages, hidden sources"
date: 2021-03-30T16:03:23+01:00
draft: false
tags: ["Hugo"]
---

Instructions to build an Hugo site from scratch, manage it with git, and publish in GitHub Pages. In this scenario only the result files are being uploaded to Github Pages, not the source files.

The source files themselves are also in git. Intentionally the scenario is not publishing those sources publicly in GitHub.

<!--more-->

Steps are:
* Create the root folder structure. Will contain Hugo and other materials such as documentation
* Create a GitHub empty project, named 'siteweb'. Will publish the pages with GitHub Pages.
* Create a local folder with a readme.md, update GitHub and ensure a 'Master' branch
* Create a Hugo site with a chosen theme
* Create a Git project for the Hugo Sources with a first commit. This one will not be connected to GitHub
* Create a Git subtree in the publish area, in sync with the GitHub 'siteweb'
* Do some site changes, build the site, commit the changes, push the siteweb subtree

The folder structure is:
```
+-- all-sites                (root for all web projects)
    +-- mysite               (the project being created here)
        +-- hugo             (the hugo root folder, versions managed by Git)
        |   +-- content      (standard hugo folder)
        |   +-- themes       (standard hugo folder)
        |   |   +-- mainroad (theme folder, kept updated via a Git submodule)
        |   +-- public       (a folder in sync with the root folder of the project in GitHub via a Git Subtree)
        |   |   +-- docs     (the folder where generated pages reside, with the name GitHub Pages expect)
        |   +-- other hugo folders not shown
        +-- other project folders not shown (for example documentation, prototypes, ...)
```
# Create the root folder structure

1. Create the site parent folder. Here all content related to the site, other than Hugo's materials, will reside.
For example, web prototypes or documentation could reside here.
```
\> cd all-sites
all-sites\> mkdir mysite
all-sites\> cd mysite
all-sites\mysite\>
```

All materials for the web site will reside here. For example, project documentation, drawings, or prototypes

# Create a GitHub empty project
The GitHub project will be used to publish the web site, via GitHub Pages.

2. Access GitHub and create a new project named 'siteweb'.

Ensure it is an empty project (no readme, no license, no nothing)

# Create a local folder with a readme.md, update GitHub and ensure a 'Master' branch

3. Create a temporary folder, named 'temp', with a single 'readme.md' file
```
all-sites\mysite\>
all-sites\mysite\> mkdir temp
all-sites\mysite\> cd temp
all-sites\mysite\temp\> echo Hello > readme.md
```

4. Create a Git repository in that folder, commit the changes
```
all-sites\mysite\temp\> git init
all-sites\mysite\temp\> git add .
all-sites\mysite\temp\> git commit -m "first commit"
```

5. Push such Git repository to the GitHub 'siteweb' project

```
all-sites\mysite\temp\> git remote add origin https://github.com/myaccount/siteweb.git
all-sites\mysite\temp\> git push -u origin master
```

6. Remove the temporary folder
```
all-sites\mysite\temp\> cd ..
all-sites\mysite\> rm -R --force temp
```

# Create a Hugo site with a chosen theme

7. Create the Hugo site in a folder named 'hugo', change the working folder to it.

The 'Hugo part' of the project is simply named 'hugo' assuming that the containing folder, with a suggestive name,
contains other parts such as documentation or prototypes.
```
all-sites\mysite\> hugo new site hugo
all-sites\mysite\> cd hugo
all-sites\mysite\hugo\>
```

8. Create a Git repository in the Hugo root folder.

This Git repository will not be connected to GitHub. It will be used to manage the multiple versions of your sources.

```
all-sites\mysite\hugo\> git init
```

9. Bring your favorite template, from the Hugo's extensive library.

Below example works with the Mainroad theme.
Using submodule will facilitate updating the theme when there are new versions.
```
all-sites\mysite\hugo\> git submodule add https://github.com/vimux/mainroad themes/mainroad
```

10. Tell Config.toml that you are using such theme
```
all-sites\mysite\hugo\> echo theme = "mainroad" >> config.toml
```

11. Configure file config.toml with specific entries for the thee being used.
In the case of mainroad, find a sample configuration file in https://themes.gohugo.io/mainroad/

12. Create a first page.
```
all-sites\mysite\hugo\> hugo new blog\hello.md
```
13. In the newly created page, put some content after the front matter.

Say "Hello world". Set the 'draft' option to false
Created page is 'content\blog\hello.md'

```
---
title: "Hello"
date: 2021-03-30T17:20:36+01:00
draft: false
---
Hello world
```

14. Test that the site is working

Run the local server,
```
all-sites\mysite\hugo\> hugo server -D
```

And access the local host in http://localhost:1313/

# Create a Git subtree to publish result pages

15. Commit current folder content
```
all-sites\mysite\hugo\> git add .
all-sites\mysite\hugo\> git commit -m "preparing subtree"
```

16. Pull the GitHub project 'siteweb' to the publish folder

```
all-sites\mysite\hugo\> git subtree add --prefix public https://github.com/myaccount/siteweb.git master --squash
```

16. Change the output folder to public\docs

Rational is that GitHub Pages will only publish the 'docs' folder.
Edit the config.toml file and set the publish dir as below.

```
publishDir = "public/docs"
```

17. Build the web site

Change the existing 'content\blog\hello.md' page or create new pages. Then build the resulting site.
```
all-sites\mysite\hugo\> hugo
```

18. Commit changes and publish the result
```
all-sites\mysite\hugo\> git add .
all-sites\mysite\hugo\> git commit -m "first publishing"
all-sites\mysite\hugo\> git subtree push --prefix public https://github.com/myaccount/siteweb.git master
```

# Change site content, build and publish

19. Do whatever changes you need.
Repeat the build/commit/push commands to publish.

We are also deleting folder public/docs in case some pages were removed. Hugo does not delete such pages.
```
all-sites\mysite\hugo\> rm -R --force public\docs
all-sites\mysite\hugo\> hugo
all-sites\mysite\hugo\> git add .
all-sites\mysite\hugo\> git commit -m "some comment"
all-sites\mysite\hugo\> git subtree push --prefix public https://github.com/myaccount/siteweb.git master
```

# Set-up a custom domain

20. Create a CNAME file in the publishing root folder, containing your custom domain.

```
all-sites\mysite\hugo\> echo example.com > public\docs\CNAME
```

21. Commit and publish
```
all-sites\mysite\hugo\> git add .
all-sites\mysite\hugo\> git commit -m "some comment"
all-sites\mysite\hugo\> git subtree push --prefix public https://github.com/myaccount/siteweb.git master
```

22. Create an A-Record pointing GitHub Pages ip.

* 185.199.108.153
* 185.199.109.153
* 185.199.110.153
* 185.199.111.153

There are distinct instructions to redirect a sub-domain such as www.example.com.
See GitHub documentation in https://docs.github.com/pt/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site

Visit GitHub settings page and set the "Enforce https" flag.
