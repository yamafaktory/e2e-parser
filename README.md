# e2e-parser [![Build Status](https://travis-ci.org/yamafaktory/e2e-parser.svg?branch=master)](https://travis-ci.org/yamafaktory/e2e-parser)

> A small Haskell shell utility that parses HTML files under a given path looking for data-e2e attributes and outputs a report.

In the end-to-end testing world, it is considered best practice to avoid using CSS ids or classes. In order to keep a clear separation of concerns in the HTML templates of your applications, specific data attributes must be, when possible, implemented. I personnaly use *data-e2e* attributes to manage my tests.

# Installation

```bash
stack install
```

# Usage

Execute this command in your terminal:

```bash
./e2e-parser-exe
```
The program will ask you the path where you want to perform the search.

# Output example

Running the previous command in the project directory will output the following report:

```bash
Please provide the path to the HTML files:
.
------------------------------------------------------------
2 file(s) scanned
------------------------------------------------------------
"./html-test-files/test.html"

Found 3 data attribute(s)
-> {:type title}
-> {:type content}
-> {:type button :as go}
------------------------------------------------------------
"./html-test-files/test-broken.html"

Found 2 data attribute(s)
-> {:type item-1}
-> {:type item-2}
------------------------------------------------------------
```
# Haskell packages

This project relies on the [turtle package](https://hackage.haskell.org/package/turtle) for the shell integration and on the [tagsoup package](https://hackage.haskell.org/package/tagsoup) for the HTML parsing part.

# License

Released under the [BSD-3 license](https://opensource.org/licenses/BSD-3-Clause).
