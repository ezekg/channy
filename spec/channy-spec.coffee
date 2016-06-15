chan = require "../src/channy"
chai = require "chai"

describe "Channy", ->
  beforeEach -> chan._chans = {}

  describe "open", ->
    it "should open a channel", ->
      chan.open "chan:open"
      chai.expect Object.keys(chan._chans).length
        .to.not.equal 0
      chai.expect chan._chans
        .to.have.key "chan:open"

  describe "close", ->
    it "should close a channel", ->
      chan.open "chan:close"
      chan.close "chan:close"
      chai.expect Object.keys(chan._chans).length
        .to.equal 0
      chai.expect chan._chans
        .to.not.have.key "chan:close"

    it "should not close all channels", ->
      chan.open "chan:keep-open"
      chan.open "chan:close"
      chan.close "chan:close"
      chai.expect Object.keys(chan._chans).length
        .to.not.equal 0
      chai.expect chan._chans
        .to.have.key "chan:keep-open"

  describe "join", ->
    it "should join and open a channel", ->
      chan.join "chan:join+open", -> null
      chai.expect chan._chans.length
        .to.not.equal 0
      chai.expect chan._chans
        .to.have.key "chan:join+open"

    it "should join a channel", ->
      chan.join "chan:join", f = -> null
      chai.expect chan._chans["chan:join"].indexOf f
        .to.equal 0

    it "should not allow non-funcs to join a channel", ->
      a = chan.join "chan:join", null
      b = chan.join "chan:join", "string"
      c = chan.join "chan:join", 1
      chai.expect(a).to.equal false
      chai.expect(b).to.equal false
      chai.expect(c).to.equal false

  describe "leave", ->
    it "should leave a channel", ->
      chan.join "chan:leave", f = -> null
      chan.join "chan:leave", -> null
      chan.leave "chan:leave", f
      chai.expect chan._chans["chan:leave"].indexOf f
        .to.equal -1

    it "should not allow non-funcs to leave a channel", ->
      a = chan.join "chan:leave", null
      b = chan.join "chan:leave", "string"
      c = chan.join "chan:leave", 1
      chai.expect(a).to.equal false
      chai.expect(b).to.equal false
      chai.expect(c).to.equal false

  describe "message", ->
    it "should message a channel", ->
      message = null
      chan.join "chan:message", -> message = "hello world"
      chan.message "chan:message"
      chai.expect(message).to.equal "hello world"

    it "should message a channel with an argument", ->
      message = null
      chan.join "chan:message", (a) -> message = "hello #{a}"
      chan.message "chan:message", "world"
      chai.expect(message).to.equal "hello world"

    it "should message a channel with many arguments", ->
      message = null
      chan.join "chan:message", (a, b, c) -> message = "hello #{a}, #{b} and #{c}"
      chan.message "chan:message", "sky", "world", "universe"
      chai.expect(message).to.equal "hello sky, world and universe"

    it "should message many channels", ->
      messages = []
      chan.join "chan:messages", -> messages.push "hello a"
      chan.join "chan:messages", -> messages.push "hello b"
      chan.join "chan:messages", -> messages.push "hello c"
      chan.message "chan:messages"
      chai.expect(messages).to.deep.equal ["hello a", "hello b", "hello c"]
