# bash4all
Normalizing bash administration across different OS-es and distributions plus various helpful aliases and functions.

With that it is meant that you can use bash similar way in different environments 
with the help of so called modes and aliases.
For instance we have install mode for installing packages where
you only need to know package name.
And we have scm-git mode which enhances git usage.
Keyboard shortcuts should should work the same documented way across distributions / OSes.
This script also enhances configuration, autocompletion and default settings.
Helps bridge the gap between different systems.
Effective documentation is keeped in wiki.

Help and [contributions](https://github.com/tpanj/bash4all/wiki/Contribute)
are highly desirable and appreciated.

# Installation
For Unix-like operating system ( macOS, Linux, BSD).
Run installer with bash script.
Script will automatically install git from "your" repository 
(if not already available on system),
clone this repository and bind your current user to it.

**via curl:**

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/tpanj/bash4all/master/install.bash)"

**via wget:**

    bash -c "$(wget -O- https://raw.githubusercontent.com/tpanj/bash4all/master/install.bash)"

# Usage
Here are described some examples of usage. The rest is maintained in [Wiki](https://github.com/tpanj/bash4all/wiki) pages.

## Modes
### pkg - example managing software packages and services
Aliases:
* I - unconditionally installs package(s)
* i - installs package(s)
* U - unconditionally uninstall package(s)
* u - uninstall package(s)
* S - service command (start | stop )

Example:
```bash
mode pkg
I vlc # installs vlc
```
### scm - managing software packages and services

## Keys bindings

**Begin of line search**
Type beginning of previous command and then <kbd>PgUp</kbd> / <kbd>PgDown</kbd>
cycles through history only for matching entries.

**Full text backward search**
Famous <kbd>Ctrl</kbd> + <kbd>r</kbd> search through commands history.

## Core functions
**mode** for a particular job
* pkg -  mode for installing and uninstalling software
* scm - Source Code Management for <git | svn >. This module starts also automatically when in SCM folder

**extract** archive
Extracting to current dir

## Generic SCM commands
* **co** URL - Clone or checkout repository. Default set to git type
* **add** item - add item under SCM
* **commit** - track change
* **push** - publish changes
* **pull** - get changes from remote
* **branch** - create branch
* **log** - show commit history

# More
You can also personalize installer. The rest of doc is found in 
[Wiki](https://github.com/tpanj/bash4all/wiki) pages to minimize core repository.