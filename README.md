# channy
[![Travis](https://img.shields.io/travis/ezekg/channy.svg?style=flat-square)](https://travis-ci.org/ezekg/channy)
[![NPM](https://img.shields.io/npm/v/channy.svg?style=flat-square)](https://www.npmjs.com/package/channy)
[![Bower](https://img.shields.io/bower/v/channy.svg?style=flat-square)](http://bower.io/search/?q=channy)

Channy is a Go channel-like observer that allows easy orchestration of arbitrary events.

## Install
```
npm install channy --save
```

Or with Bower,
```
bower install channy --save
```

## Usage
`Channy` is a static class, so you don't need to instantiate it with `new`. See
inline documentation for detailed breakdowns on what each method does, otherwise
see below for basic usage.

```coffee
chan = require "channy"

chan.join "chan:channy", (x) ->
  console.log "hello, #{x}"

chan.message "chan:channy", "channy"
# console.log => "hello, channy"
```

#### Open a channel
Open up an empty channel. `open` takes a channel name and returns `void`.

```coffee
chan.open "a:channel"
```

#### Close a channel
Close a channel. `close` takes a channel name and returns `void`.

```coffee
chan.close "a:channel"
```

#### Join a channel
Join a channel. This will automaticcaly create the channel if it doesn't already
exist. `join` takes a channel name and callback function and returns
`void`.

```coffee
chan.join "a:channel", (args...) -> # ...
```

#### Leave a channel
Leave a channel. This will automatically close the channel if no subscribers
exist for it. `leave` takes a channel name and callback function
and returns `void`.

```coffee
callback = -> # ...

chan.join "a:channel", callback

chan.leave "a:channel", callback
```

#### Message a channel
Send a message to a channel, executing all callbacks currently subscribed.
`message` takes a channel name an infinite number of arguments to be
passed to the callback function, and returns `void`.

```coffee
chan.join "chan:channy", (x) -> console.log "hello, #{x}"

chan.message "chan:channy", "channy"
# console.log => "hello, channy"
```

## License
MIT © [Ezekiel Gabrielse](https://github.com/ezekg)
