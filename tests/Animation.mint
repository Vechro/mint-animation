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
}
