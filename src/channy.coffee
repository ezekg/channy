"use strict"

###
# Channy is a static class responsible for managing global channels. A channel
# name should be namespaced (for example, "namespace:channel"). A channel may be
# closed at any time, leaving all existing callbacks for it to be forgotten.
###
module.exports =
class Channy
  @_chans: {}

  ###
  # Open up an empty channel.
  #
  # @param {Str} chan - Channel to open.
  #
  # @return {Void}
  ###
  @open: (chan) ->
    @_chans[chan] ?= []

  ###
  # Close a channel.
  #
  # @param {Str} chan - Channel to close.
  #
  # @return {Void}
  ###
  @close: (chan) ->
    tmp = @_chans
    delete tmp[chan]
    @_chans = tmp

  ###
  # Join a channel. This will automatically create the channel if it doesn't
  # already exist.
  #
  # @param {Str}  chan     - Channel to join.
  # @param {Func} callback - Callback to execute when channel is messaged.
  #
  # @return {Func} callback
  ###
  @join: (chan, callback) ->
    return false unless typeof callback is "function"
    @.open chan
    @_chans[chan].push callback
    callback

  ###
  # Leave a channel. This will automatically close the channel if no subscribers
  # currently exist for it.
  #
  # @param {Str}  chan     - Channel to leave.
  # @param {Func} callback - Callback to remove.
  #
  # @return {Arr} Array containing the removed callback.
  ###
  @leave: (chan, callback) ->
    return false unless typeof callback is "function"
    index = @_chans[chan].indexOf callback
    return false unless index >= 0
    callbacks = @_chans[chan]?.splice index, 1
    @.close chan unless @_chans[chan].length
    callbacks

  ###
  # Send a message to a channel. This executes all callbacks currently
  # subscribed to the channel.
  #
  # @param {Str} chan - Channel to message.
  # @param {*}   args - Arguments to pass to callback.
  #
  # @return {*} Return value of callback.
  ###
  @message: (chan, args...) ->
    return unless @_chans[chan]
    callback.apply @, args for callback in @_chans[chan]
