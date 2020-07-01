enum Animation.Error {
  Unknown
  TypeError
  SyntaxError
  NotSupportedError
  InvalidStateError
  AbortError
  HierarchyRequestError
}

record Animation.Configuration {
  keyframes : Array(Array(Tuple(String, String))),
  options : Array(Tuple(String, String)),
  duration : Number
}

module Animation {
  /* Animates the selected element with the given Animation.Configuration */
  fun animate (
    element : Dom.Element,
    current : Animation.Configuration
  ) : Result(Animation.Error, Animation) {
    `
    (() => {
      const keyframes = #{current.keyframes}.map(frame => {
        const _ = {}
        frame.forEach(entry => _[entry[0]] = entry[1])
        return _
      })

      const options = {
        duration: #{current.duration}
      }

      #{current.options}.map(option => options[option[0]] = option[1])

      try {
        return #{Result::Ok(`#{element}.animate(keyframes, options)`)}
      } catch (error) {
        switch (error.name) {
          case 'TypeError':
            return #{Result::Err(Animation.Error::TypeError)}
          case 'SyntaxError':
            return #{Result::Err(Animation.Error::SyntaxError)}
          case 'NotSupportedError':
            return #{Result::Err(Animation.Error::NotSupportedError)}
          case 'InvalidStateError':
            return #{Result::Err(Animation.Error::InvalidStateError)}
          case 'AbortError':
            return #{Result::Err(Animation.Error::AbortError)}
          case 'HierarchyRequestError':
            return #{Result::Err(Animation.Error::HierarchyRequestError)}
          default:
            return #{Result::Err(Animation.Error::Unknown)}
        }
      }
    })()
    `
  }

  /* First parameter must be an array comprised of one or more tuples which in turn contain a CSS property and its value. */
  fun step (
    frame : Array(Tuple(String, String)),
    current : Animation.Configuration
  ) : Animation.Configuration {
    { current | keyframes = Array.push(frame, current.keyframes) }
  }

  /* TODO: Check if offset already doesn't exist as the last element in array */
  fun withOffset (offset : Number, current : Animation.Configuration) : Animation.Configuration {
    { current | keyframes = Array.push(Array.push(offsetTuple, lastElement), current.keyframes) }
  } where {
    offsetTuple =
      {"offset", Number.toString(offset)}

    lastElement =
      Array.lastWithDefault([], current.keyframes)

    modifiedLastElement =
      Array.push(offsetTuple, lastElement)
  }

  /* Sets the total duration of the animation. */
  fun duration (duration : Number, current : Animation.Configuration) : Animation.Configuration {
    { current | duration = duration }
  }

  /* Defines the amount of times to play the animation. */
  fun iterations (
    amount : Animation.Iterations,
    current : Animation.Configuration
  ) : Animation.Configuration {
    { current |
      options =
        Array.push(
          {
            "iterations", (amount
            |> Animation.Iterations.toString)
          },
          current.options)
    }
  }

  /*
  Describes at what point in the iteration the animation should start.
  Accepts any float value greater than or equal to 0.
  */
  fun iterationStart (amount : Number, current : Animation.Configuration) : Animation.Configuration {
    { current |
      options =
        Array.push(
          {
            "iterationStart", (amount
            |> Number.toString)
          },
          current.options)
    }
  }

  /* The number of milliseconds to delay the start of the animation. */
  fun delay (amount : Number, current : Animation.Configuration) : Animation.Configuration {
    { current |
      options =
        Array.push(
          {
            "delay", (amount
            |> Number.toString)
          },
          current.options)
    }
  }

  /* The number of milliseconds to delay after the end of the animation. */
  fun endDelay (amount : Number, current : Animation.Configuration) : Animation.Configuration {
    { current |
      options =
        Array.push(
          {
            "endDelay", (amount
            |> Number.toString)
          },
          current.options)
    }
  }

  /* Defines how the animation moves through its timeline. */
  fun direction (
    dir : Animation.Directions,
    current : Animation.Configuration
  ) : Animation.Configuration {
    { current |
      options =
        Array.push(
          {
            "direction", (dir
            |> Animation.Directions.toString)
          },
          current.options)
    }
  }

  /* Sets the rate of the animation's change over time. */
  fun easing (
    easingType : Animation.Easing,
    current : Animation.Configuration
  ) : Animation.Configuration {
    { current |
      options =
        Array.push(
          {
            "easing", (easingType
            |> Animation.Easing.toString)
          },
          current.options)
    }
  }

  /* Defines how the element to which the animation is applied should look when the animation sequence is not actively running. */
  fun fill (
    fillType : Animation.Fill,
    current : Animation.Configuration
  ) : Animation.Configuration {
    { current |
      options =
        Array.push(
          {
            "fill", (fillType
            |> Animation.Fill.toString)
          },
          current.options)
    }
  }

  fun create : Animation.Configuration {
    {
      keyframes = [],
      options = [],
      duration = 0
    }
  }

  /* Pauses animation. */
  fun pause (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.pause()
      return #{animation}
    })()
    `
  }

  /* Resumes animation. */
  fun play (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.play()
      return #{animation}
    })()
    `
  }

  /* Skips to the end (or start if direction is reversed) of the animation. */
  fun finish (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.finish()
      return #{animation}
    })()
    `
  }

  /* Clears all keyframes and aborts animation playback. */
  fun cancel (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.cancel()
      return #{animation}
    })()
    `
  }

  /* Reverses playback direction. */
  fun reverse (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.reverse()
      return #{animation}
    })()
    `
  }

  /* Sets animation playback rate. */
  fun setPlaybackRate (rate : Number, animation : Animation) : Animation {
    `
    (() => {
      #{animation}.playbackRate = ${rate}
      return #{animation}
    })()
    `
  }

  /* Returns current animation playback rate. */
  fun getPlaybackRate (animation : Animation) : Number {
    `
    #{animation}.playbackRate
    `
  }

  /* Sets the current time value of the animation in milliseconds, whether running or paused. */
  fun setCurrentTime (time : Number, animation : Animation) : Animation {
    `
    (() => {
      #{animation}.currentTime = ${time}
      return #{animation}
    })()
    `
  }

  /*
  The current time value of the animation in milliseconds, whether running or paused.
  It can fail to return a value if the animation lacks a timeline, is inactive or hasn't been played yet.
  */
  fun getCurrentTime (animation : Animation) : Maybe(Number) {
    `
    (() => {
      const t = #{animation}.currentTime
      if (t === null) {
        return #{Maybe::Nothing}
      } else {
        return #{Maybe::Just(`t`)}
      }
    })()
    `
  }

  /*
  Commits the end styling state of an animation to the element being animated, even after that animation has been removed.
  It will cause the end styling state to be written to the element being animated, in the form of properties inside a style attribute.
  */
  fun commitStyles (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.commitStyles()
      return #{animation}
    })()
    `
  }

  /*
  Indicates whether the animation is currently waiting for an asynchronous operation such as initiating playback or pausing a running animation.
  Returns `true` if the animation is pending, otherwise `false`.
  */
  fun pending (animation : Animation) : Bool {
    `
    #{animation}.pending
    `
  }

  /* Returns the current `playState` of the animation. */
  fun playState (animation : Animation) : Animation.PlayState {
    `
    const s = #{animation}.playState
    switch (s) {
      case "idle":
        return ${Animation.PlayState::Idle}
      case "running":
        return ${Animation.PlayState::Running}
      case "paused":
        return ${Animation.PlayState::Paused}
      case "finished":
        return ${Animation.PlayState::Finished}
    }
    `
  }
}
