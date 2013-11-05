# MIMETypes

A simple Elixir module that maps MIME types to file extensions and vice
versa.

## Usage

```iex
iex> MIMETypes.type("json")
"application/json"
iex> MIMETypes.extensions("application/json")
["json"]
```

## mime.types

This module uses the public domain [`mime.types`][1] file from the
Mailcap project. The file is parsed during compilation time and
embedded directly into the module.

[1]: https://git.fedorahosted.org/cgit/mailcap.git/plain/mime.types
