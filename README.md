# Overview

This is a [Pandoc Lua filter](https://pandoc.org/lua-filters.html) that replaces absolute links with links relative to the URL of the document. See [test/in/main.md](test/in/main.md) for example input and [test/expected/main.md](test/expected/main.md) for what the output looks like.

# Usage

The document metadata must contain a `url` attribute which indicates where the document itself is intended to reside. For example, if you put this metadata block at the top of a markdown document:

```
---
url: https://example.com/stuff/boring
---
```

...the filter would rewrite any link to `https://example.com/stuff/awesome` to be `../awesome`.

To run the filter, download the [pandoc-link-relativizer-filter.lua](pandoc-link-relativizer-filter.lua) file and use `--lua-filter path/to/pandoc-link-relativizer-filter.lua` when when invoking pandoc.

# Testing

Some test pandoc markdown files are in [test/in](test/in) and the corresponding outputs are in [test/expected](test/expected).

There is a script that will run pandoc on all the test files and diff the outputs against the expected outputs. To ensure you're using the intended version of pandoc, I suggest running them in Docker. If you have Docker installed and are on Mac/Linux, just run `./test/docker-test.sh` to build the image and run the tests.

# License

See the [LICENSE](LICENSE) file.
