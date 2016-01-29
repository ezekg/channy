# channy
[![Travis](https://img.shields.io/travis/ezekg/channy.svg?style=flat-square)](https://travis-ci.org/ezekg/channy)

Channy is a Go channel-like observer that allows easy orchestration of arbitrary events.

## Install
```
$ npm install channy --save
```

## Usage
See inline documentation for additional details.

```coffee
chan = require "channy"

chan.join "chan:channy", (x) ->
  console.log "hello, #{x}"

chan.message "chan:channy", "channy"
# console.log => "hello, channy"
```

## License
MIT © [Ezekiel Gabrielse](https://github.com/ezekg)
