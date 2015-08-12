# MIME

A simple Elixir library that maps MIME types to file extensions and vice
versa.

## Usage

```iex
iex> MIME.Types.type("json")
"application/json"
iex> MIME.Types.extensions("application/json")
["json"]
iex> MIME.Types.path("fixtures/users.json")
"application/json"
```

## mime.types

This module uses the public domain [`mime.types`][1] file from the
Mailcap project. The file is parsed during compilation time and
embedded directly into the module.

## TODO

- MIME.Magic based on Apache httpd's [`magic`](2) file.

[1]: https://git.fedorahosted.org/cgit/mailcap.git/plain/mime.types
[2]: https://svn.apache.org/repos/infra/websites/cms/webgui/conf/magic
