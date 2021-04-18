---
title: "Shortcodes in Hugo static page generator"
date: 2021-03-31T16:03:23+01:00
draft: false
tags: ["Hugo"]
---

Shortcodes are used in .md files. They are a form of customizing the resulting html whenever the .md format does not gives what you need.

<!--more-->

# Structure

Use the below folder structure

```
root
 +-- contend
       +--- a_md_file.md
 +-- layouts
       +-- shortcodes
             +-- example.html
```

# Shortcode file
The example is a shortcode that creates an href to an external window.
If you use a link to an external page, it will open in the same window. This short code allows linking in an external window.

```
File example.html:
<a href="{{ .Get  1 }}" target="_blank">{{ .Get  0 }}</a>
```

The shortcode uses the first parameter (numbered zero) as the text within href. It uses the second parameter (numbered one) as the target url.

# Using the shortcode

Place the shortcode name and parameters between \{\{\< and \>\}\}. For example
```
File a_md_file.md:
Use this to open {{< shortcode_open >}} example "Google" "https://www.google.com" {{< shortcode_close >}} in an external window
```

Result:

Use this to open {{< link "Google" "https://www.google.com" >}} in an external window
