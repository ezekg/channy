// Generated by CoffeeScript 1.10.0
"use strict";

/*
 * Channel is a static class responsible for managing global channels. A channel
 * name should be namespaced (for example, "namespace:event"). A channel may be
 * closed at any time, leaving all existing callbacks for it to be forgotten.
 */
var Channel,
  slice = [].slice;

module.exports = Channel = (function() {
  function Channel() {}

  Channel._chans = {};


  /*
   * Open up an empty channel
   *
   * @param {Str} chan - Channel to close
   *
   * @return {Void}
   */

  Channel.open = function(chan) {
    var base;
    return (base = this._chans)[chan] != null ? base[chan] : base[chan] = [];
  };


  /*
   * Close a channel
   *
   * @param {Str} chan - Channel to close.
   *
   * @return {Void}
   */

  Channel.close = function(chan) {
    var tmp;
    tmp = this._chans;
    delete tmp[chan];
    return this._chans = tmp;
  };


  /*
   * Join a channel. This will automaticcaly create the channel if it doesn't
   * already exist.
   *
   * @param {Str}  chan     - Channel to join.
   * @param {Func} callback - Callback to execute when channel is messaged.
   *
   * @return {Func} callback
   */

  Channel.join = function(chan, callback) {
    this.open(chan);
    this._chans[chan].push(callback);
    return callback;
  };


  /*
   * Leave a channel. This will automatically close the channel if no subscribers
   * exist for it.
   *
   * @param {Str}  chan     - Channel to leave.
   * @param {Func} callback - Callback to remove.
   *
   * @return {Arr} Array containing the removed callback(s).
   */

  Channel.leave = function(chan, callback) {
    var ref;
    if ((ref = this._chans[chan]) != null) {
      ref.splice(this._chans[chan].indexOf(callback), 1);
    }
    if (!this._chans[chan].length) {
      return this.close(chan);
    }
  };


  /*
   * Send a message to a channel, executing all callbacks currently subscribed.
   *
   * @param {Str} chan - Channel to message.
   * @param {*}   args - Arguments to pass to callback.
   *
   * @return {*} Return value of callback.
   */

  Channel.message = function() {
    var args, callback, chan, i, len, ref, results;
    chan = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
    if (!this._chans[chan]) {
      return;
    }
    ref = this._chans[chan];
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      callback = ref[i];
      results.push(callback.apply(this, args));
    }
    return results;
  };

  return Channel;

})();