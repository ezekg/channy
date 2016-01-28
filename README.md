# channy
[![Travis](https://img.shields.io/travis/ezekg/channy.svg?style=flat-square)](https://travis-ci.org/ezekg/channy)

## Install

```
$ npm install channy --save
```

## Usage
```coffee
chan = require "chan"

chan.join "chan:channy", (x) ->
  console.log "hello, #{x}"

chan.message "chan:channy", "channy"
# console.log => "hello, channy"
```

## License
MIT © [Ezekiel Gabrielse](https://github.com/ezekg)
