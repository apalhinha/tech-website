---
title: "Sitemap in Hugo static page generator"
date: 2021-04-09T16:03:23+01:00
draft: false
tags: ["Hugo"]
---

Hugo generates a default sitemap for your site containing all pages and links. Such sitemap can be customized.

<!--more-->

# Structure

Use the below folder structure. You can get a initial sitemap file for customization in {{< link "gohugo.io" "https://gohugo.io/templates/sitemap-template/" >}}

```
root
 +-- layouts
 |    +-- _default
 |          +-- sitemap.xml
```

# customizing

Change way the range of pages is processed.
For example, instead of
```
{{ range .Data.Pages }}
  {{- if .Permalink -}}
<url>
... rest not shown
```

The below would not include section (subfolder) "testing" in the sitemap.

```
{{ range .Data.Pages }}
  {{- if .Permalink -}}{{- if ne .Section "testing" -}}
<url>
... rest not shown
```
