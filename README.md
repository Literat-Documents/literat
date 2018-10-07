# Literat *this tool is still under heavy development - use at your own risk*

**Literat is a Framework and Tool for generating beautiful Documents.**

## What's Literat

*to be done*

## ToDo's

- [x] create the tool
- [ ] make tool stable by adding some checks
- [X] implementing automatic creation of template folder
- [ ] add more templates
  - [ ] create templates
  - [o] implement template managing features

## Getting Started
### Preparation

*to be done*

### Installation

```
$ git clone <GITURL>
$ gem build literat.gemspec
$ gem install $(ls *.gem | sort | tail -n1)
```

### Your first Project

First create a folder for your project:

```
~$ mkdir /tmp/my-first-project
~$ cd /tmp/my-first-project 
/tmp/my-first-project$
```

Next initialize a new project.

```
/tmp/my-first-project$ literat init -t article
/tmp/my-first-project$ ls
content.md  settings.yml
```

At this point you can edit the visible project files and add your content.

At last build your project using the **build** command


```
/tmp/my-first-project$ literat build
```

## Building your own Templates

*to be done*
