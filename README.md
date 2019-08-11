# Data Platform Engineering Handbook

You can view rendered version at [https://handbook.dtone.engineering](https://handbook.dtone.engineering). Access is currently limited to DTOne employees, but there is an appetite to release it to public.

## Building handbook locally

We are using [Sphinx](https://www.sphinx-doc.org) for managing the whole document. You will need `python3` and `virtualenv` installed to build it locally. When installed, rest is just question of

```bash
make html
```

this will built a fresh static version of the site, which you can view at your browser. When pushed to `master` (please don't do it without proper MR), CI/CD pipeline will build it and publish it as a GitLab page at [https://handbook.dtone.engineering](https://handbook.dtone.engineering).

## Using Markdown

The standard markup used by Sphix is called [reStructuredText](https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html) (it uses file extension `.rst`). It is very powerful, but a bit confusing for people who are used to [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

We have enabled extension [recommonmark](https://recommonmark.readthedocs.io) which seamlessly integrates Markdown into Sphinx workflow. It even allows for [embedding and evaluating RST](https://recommonmark.readthedocs.io/en/latest/auto_structify.html#embed-restructuredtext), when you need something special.
