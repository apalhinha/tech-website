---
title: "A configuration for DNS, Github Pages and Google Analytics"
date: 2021-04-18T09:52:46+01:00
draft: false
---
Used configurations for a web-site hosted in GitHub Pages, in an Apex (top-level) domain
* Site is yourdomain.com
* A redirect from {{< nolink "www.yourdomain.com" >}}

<!--more-->


# GitHub configurations
* Activate GitHub Pages
* Fill-in CNAME. Should contain the single word {{< nolink "yourdomain.com" >}}
```
yourdomain.com
```

# DNS configurations
* 4 Distinct A-Records on {{< nolink "yourdomain.com" >}} with the GitHub Pages IPs as per {{< link "GitHub documentation" "https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site">}}. Urls are
  * 185.199.108.153
  * 185.199.109.153
  * 185.199.110.153
  * 185.199.111.153
* Similar 4 records for {{< nolink "www.yourdomain.com">}}, so that www redirects to the top level domain

# Hugo configuration
Set the baseurl setting to the Apex domain, in config.toml
```
baseurl = "https://yourdomain.com/"
```

Ensure your template has a "base" definition in the baseof file. This will avoid "http links inside a https site" errors
```
<head>
...
<base href="{{ .Site.BaseURL }}"> <!-- added this base -->
</head>
```
# Search Analytics
Set a google-search property in the {{< link "Search Console" "https://search.google.com/search-console">}}

Used a "Domain property" with a txt file in DNS for verifications. Instructions are there when you do "Add Property" in the Search Console

Fill-in the sitemap filename

# Analytics
Create a Universal Property, set it in the config.toml file as per your theme instructions

Connect the analitics property to the Search Console property. Do this in the "product linking" menu
