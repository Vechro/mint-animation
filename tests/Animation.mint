suite "Animation" {
  test "No animation errors" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.withOffset(0.1)
          |> Animation.step([{"transform", "rotate(15deg) translateX(10em)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(100)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error =>
                Promise.reject(
                  error
                  |> Animation.Error.toString)
            }
          })
      }
    }
  }

  test "NotSupportedError when offset is applied before the first step" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.withOffset(0.1)
          |> Animation.step([{"transform", "rotate(15deg) translateX(10em)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(1)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.reject("no error")

              Result::Err error =>
                Promise.resolve(
                  error
                  |> Animation.Error.toString)
            }
          })
      }
    }
  }

  test "Animation pauses" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(100)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error =>
                Promise.reject(
                  error
                  |> Animation.Error.toString)
            }
          })
        |> then(
          (animation : Animation) {
            try {
              Animation.pause(animation)

              if (Animation.playState(animation) == Animation.PlayState::Paused) {
                Promise.resolve(animation)
              } else {
                Promise.reject("Animation is not paused")
              }
            }
          })
      }
    }
  }

  test "Large animation config" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}, {"color", "#fdb"}])
          |> Animation.withOffset(0.1)
          |> Animation.step([{"transform", "rotate(360deg)"}, {"color", "#111"}])
          |> Animation.duration(100)
          |> Animation.iterations(Animation.Iterations::Just(10))
          |> Animation.iterationStart(3.5)
          |> Animation.delay(300)
          |> Animation.endDelay(500)
          |> Animation.direction(Animation.Directions::AlternateReverse)
          |> Animation.easing(Animation.Easing::EaseInOut)
          |> Animation.fill(Animation.Fill::Forwards)
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error =>
                Promise.reject(
                  error
                  |> Animation.Error.toString)
            }
          })
      }
    }
  }

  test "Getting and setting animation playback rate" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(100)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error =>
                Promise.reject(
                  error
                  |> Animation.Error.toString)
            }
          })
        |> then(
          (animation : Animation) {
            try {
              Animation.setPlaybackRate(0.4, animation)

              if (Animation.getPlaybackRate(animation) == 0.4) {
                Promise.resolve(animation)
              } else {
                Promise.reject("PlaybackRate get/set error")
              }
            }
          })
      }
    }
  }

  test "Animation resumes playback after pausing and resuming" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(100)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error =>
                Promise.reject(
                  error
                  |> Animation.Error.toString)
            }
          })
        |> then(
          (animation : Animation) {
            try {
              Animation.pause(animation)
              Animation.play(animation)

              if (Animation.playState(animation) == Animation.PlayState::Running) {
                Promise.resolve(animation)
              } else {
                Promise.reject("Animation is not playing")
              }
            }
          })
      }
    }
  }

  test "Animation skips to end on demand" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(30000)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error =>
                Promise.reject(
                  error
                  |> Animation.Error.toString)
            }
          })
        |> then(
          (animation : Animation) {
            try {
              Animation.finish(animation)

              if (Animation.playState(animation) == Animation.PlayState::Finished) {
                Promise.resolve(animation)
              } else {
                Promise.reject("Animation is not finished")
              }
            }
          })
      }
    }
  }

  test "Get and set animation point on timeline" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(30000)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error =>
                Promise.reject(
                  error
                  |> Animation.Error.toString)
            }
          })
        |> then(
          (animation : Animation) {
            try {
              Animation.pause()
              Animation.setCurrentTime(15541, animation)

              maybeTime =
                Animation.getCurrentTime(animation)

              case (maybeTime) {
                Maybe::Just time => Promise.resolve(time)
                Maybe::Nothing => Promise.reject("Failed to get currentTime")
              }
            }
          })
        |> then(
          (time : Number) {
            try {
              if (time == 15541) {
                Promise.resolve(time)
              } else {
                Promise.reject("Incorrect currentTime")
              }
            }
          })
      }
    }
  }

  test "Cancel animation prematurely" {
    with Test.Html {
      with Test.Context {
        of(
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(30000)
          |> Animation.iterations(Animation.Iterations::Just(1))
          |> Animation.animate(Dom.createElement("div")))
        |> then(
          (result : Result(Animation.Error, Animation)) {
            case (result) {
              Result::Ok animation => Promise.resolve(animation)

              Result::Err error => Promise.reject(void)
            }
          })
        |> then(
          (animation : Animation) {
            try {
              Animation.cancel(animation)

              case (Animation.getCurrentTime(animation)) {
                Maybe::Nothing => Promise.resolve(animation)
                Maybe::Just => Promise.reject("Animation currentTime isn't null")
              }
            }
          })
      }
    }
  }
}
