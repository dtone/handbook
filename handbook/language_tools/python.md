# Tools and services for Python

## PyPI package index (for DTOne)

When using the `pip` installation tool, all the package informaton is downloaded from the PyPI website, <https://pypi.org/> (this URL is used both for automatic installation and for the web application listing the packages). However, this server hosts only *public* packages and it is necessary to provide an alternative server for private packages.

In order for DTOne's custom Python packages to be easily installable, we have our own package index (PyPI) running at <https://[username]:[password]@pypi.dtone.xyz/[key]]/>. Please replace `[username]`, `[password]` and `[key]` with values obtained from the 1password credential storage (also in the rest of this text unless stated otherwise).

### Installing a package

To install a package from our package index, use the `pip` tool in the standard way. The only difference is in the `-i` (a.k.a. `--extra-index-url`) argument supplying the above mentioned address and credentials. Example: to install the package `dtone-cool-lib`, use the following command:

```
pip install dtone-cool-lib -i https://[username]:[password]@pypi.dtone.xyz/[key]/
```

#### pip configuration file

The URL including the username and password can be (and we highly recommend this) stored in the configuration file for `pip`, which is stored at `${XDG_CONFIG_HOME:-$HOME/.config}/pip/pip.conf` (which usually points to `~/.config/pip/pip.conf`). Here, the extra index URL comes in the `[global]` section like this:

```ini
[global]
extra-index-url = https://[username]:[password]@pypi.dtone.xyz/[key]/
```

Then you can omit the `-i` setting in all your `pip` commands and the
following should be enough:

```
pip install dtone-cool-lib
```

### Depending on a package

#### requirements.txt

If you want to include a DTOne package dependency in `requirements.txt` of your project, include the `--extra-index-url` (or its `-i`) part as a line at the top of the file, as in:

```
--extra-index-url https://[username]:[password]@pypi.dtone.xyz/[key]/
dtone-cool-lib
```

Note: If you have the pip configuration file setup, installation will work also without the first line.

#### setuptools (advanced)

When writing `setup.py` installation scripts in your project, including a dependency from DTone's custom package index can be enabled by the `dependency_links` argument like this:

```
from setuptools import setup

setup(
    name='somepackage',
    install_requires=[
        'dtone-cool-lib' #, ...
    ],
    dependency_links=[
        'https://[username]:[password]@pypi.dtone.xyz/[key]/
dtone-cool-lib'
    ]
    # ...
)
```

Note: If you have the pip configuration file setup, you don't have to provide the `dependency_links` parameter.

#### Pipfile + pipenv

In your `Pipfile`, you need to do two steps:

1) Add a custom package index ("source") as follows (you will then typically have two, including the main "pypi"):

```ini
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

[[source]]
name = "dtone"
url = "https://[username]:[password]@pypi.dtone.xyz/[key]/simple"     # Note the "simple" part
verify_ssl = true

# ... rest of the file
```

2) For your dependency, write a two-item ("version" and "index") dictionary instead of a simple line:

```ini
# ...

[packages]
some_pypi_package = "*"
dtone_cool_lib = {version = "==1.2.3", index = "dtone"}
# ... rest of the file
```

Note: In this case, the pip configuration file is not applied.

### Uploading a package

Once your package is mature enough to be depended on by other projects, you can (and should) upload it to our package index.

**Note:** Before uploading, make sure that your package passes the tests (and "works"). It is not difficult to remedy a wrongly uploaded package but it adds work and can make the code of others to break.

The following works with the normal `setup.py` script of the package. It does not matter whether you are uploading for the first time ("registering") or if you are just adding a new version of an already registered package. You don't have to specify anything inside this file, everything is set by the tools:

```
python setup.py sdist upload -r https://[username]:[password]@pypi.dtone.xyz/[key]/
```

**Note:** Using `setup.py` to upload packages is considered "legacy" and you will get a warning. Despite that, it's still working and easier to work with than the recommended [twine](https://pypi.org/project/twine/) tool (installed separately). For the sake of completeness, the twine way looks like this:

```
python setup.py sdist
twine upload --repository-url=https://[username]:[password]@pypi.dtone.xyz/[key]/ dist/dtone-cool-lib-0.0.1.tar.gz
```

#### .pypirc

Again, you can store the credentials in a file, this time in `$HOME/.pypirc`. Note that this is a different file from what `pip` uses and also the syntax is slightly different. Your file will look roughly like this (if you contribute to more package indices, your file might be longer):

```
[distutils]
index-servers =
    dtone

[dtone]
    repository: https://pypi.dtone.xyz/[key]/     # Note the slash at the end!
    username: [username]
    password: [password]
```

This will allow you to use the alias for your package index:

```
python setup.py sdist upload -r dtone

# or: twine upload -r dtone
```

### Fixing a wrongly uploaded package (advanced)

If you upload a package that contains a bug, it is in most cases the best solution to release a patch version and "override" the old one. Direct manipulation should be only left to the management of PyPI itself and to solving issues that breaksecurity. Please do not do it and ask your [DevOps](mailto:infra@dtone.com) team (or in Slack [#acs-fresco-ops](https://app.slack.com/client/TH44CUB2M/CL10LQ1A9) group).