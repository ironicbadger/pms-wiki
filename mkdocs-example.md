---
title: mkdocs syntax testing
---
 
# Welcome to MkDocs

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

!!! info
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

## Project layout

    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.

Here is an example[^1] of a footnote[^2].

[^1]: This is the linked footnote explanation.
[^2]:
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

## Abbreviation expansion

The HTML specification is maintained by the W3C.

## Insert key presses

Here is more stuff. ++ctrl+alt+delete++ then press ++v+alt+shift++.

## Code snippets

=== "bash"

    ``` bash
    #include <stdio.h>

    int main(void) {
      printf("Hello world!\n");
      return 0;
    }
    ```

    Does this work with a superfence?

=== "C++"

    ``` c++ hl_lines="2 3"
    #include <iostream>

    int main(void) {
      std::cout << "Hello world!" << std::endl;
      return 0;
    }
    ```

![alex](images/alex.jpg){: align=right width=200 }

<p align="center">
<img alt="alex" src="../../images/alex.jpg">
</p>

*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium