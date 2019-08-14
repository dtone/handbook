# Data Platform Engineering Handbook

You can view rendered version at [https://handbook.dtone.engineering](https://handbook.dtone.engineering). Access is currently limited to DTOne employees, but there is an appetite to release it to public.

## Building handbook locally

We are using [Sphinx](https://www.sphinx-doc.org) for managing the whole document. You will need `python3` and `virtualenv` installed to build it locally. When installed, rest is just question of

```bash
make html
```

this will built a fresh static version of the site, which you can view at your browser. When pushed to `master` (please don't do it without proper MR), CI/CD pipeline will build it and publish it as a GitLab page at [https://handbook.dtone.engineering](https://handbook.dtone.engineering).

## Enabled extensions

### `recommonmark` -- Using Markdown

The standard markup used by Sphinx is called [reStructuredText](https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html) (it uses file extension `.rst`). It is very powerful, but a bit confusing for people who are used to [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

We have enabled extension [recommonmark](https://recommonmark.readthedocs.io) which seamlessly integrates Markdown into Sphinx workflow. It even allows for [embedding and evaluating RST](https://recommonmark.readthedocs.io/en/latest/auto_structify.html#embed-restructuredtext), when you need something special.

### Cloud Theme -- Extended tables

Came across really [nice extension](https://cloud-sptheme.readthedocs.io/en/latest/lib/cloud_sptheme.ext.table_styling.html) for extending ability to format tables.

## Theme

Current theme is [Sphinx Press](https://github.com/schettino72/sphinx_press_theme). Another quite usable theme seems to be one provided by [F5](https://github.com/f5devcentral/f5-sphinx-theme). It has a nice feature of having a `scrollspy` behaving side box with "What is on this page" TOC. Clearly designed for a long documentation. It will need more tuning though, so currently sticking with the `press`.

For F5 one want to add to `conf.py`:
```python
import f5_sphinx_theme        
html_theme = 'f5_sphinx_theme'
html_sidebars = {'**': ['searchbox.html', 'localtoc.html', 'globaltoc.html']}
```
and to `requirements.txt`
```
f5-sphinx-theme
```

If we would ever want to switch to hugo. There is an awesome theme called [hugo-theme-learn](https://github.com/matcornic/hugo-theme-learn/).
