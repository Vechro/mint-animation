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

  /* TODO: If offset is in the array, check if value is in range [0, 1] */
  fun step (
    frame : Array(Tuple(String, String)),
    current : Animation.Configuration
  ) : Animation.Configuration {
    { current | keyframes = Array.push(frame, current.keyframes) }
  }

  /* TODO: Check if value is in range [0, 1], check if offset already doesn't exist as the last element in array */
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

  fun duration (duration : Number, current : Animation.Configuration) : Animation.Configuration {
    { current | duration = duration }
  }

  fun iterations (amount : String, current : Animation.Configuration) : Animation.Configuration {
    { current | options = Array.push({"iterations", amount}, current.options) }
  }

  fun create : Animation.Configuration {
    {
      keyframes = [],
      options = [],
      duration = 0
    }
  }

  fun pause (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.pause()
      return #{animation}
    })()
    `
  }

  fun play (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.play()
      return #{animation}
    })()
    `
  }

  fun finish (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.finish()
      return #{animation}
    })()
    `
  }

  fun cancel (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.cancel()
      return #{animation}
    })()
    `
  }

  fun reverse (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.reverse()
      return #{animation}
    })()
    `
  }

  fun setPlaybackRate (rate : Number, animation : Animation) : Animation {
    `
    (() => {
      #{animation}.playbackRate = ${rate}
      return #{animation}
    })()
    `
  }

  fun getPlaybackRate (animation : Animation) : Number {
    `
    #{animation}.playbackRate
    `
  }

  fun setCurrentTime (time : Number, animation : Animation) : Animation {
    `
    (() => {
      #{animation}.currentTime = ${time}
      return #{animation}
    })()
    `
  }

  fun getCurrentTime (animation : Animation) : Number {
    `
    #{animation}.currentTime
    `
  }

  fun commitStyles (animation : Animation) : Animation {
    `
    (() => {
      #{animation}.commitStyles()
      return #{animation}
    })()
    `
  }
}
