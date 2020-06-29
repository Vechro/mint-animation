record Animation.Configuration {
  keyframes : Array(Array(Tuple(String, String))),
  options : Array(Tuple(String, String)),
  duration : Number
}

module Animation {
  fun animate (
    element : Dom.Element,
    current : Animation.Configuration
  ) : Animation {
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

      const _ = #{current.options}.map(option => {
        options[option[0]] = option[1]
      });

      #{element}.animate(
        keyframes,
        options
      );
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
    { current | keyframes = Array.push([{"offset", Number.toString(offset)}], current.keyframes) }
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
}
