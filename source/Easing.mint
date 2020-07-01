enum Animation.Easing {
  /*
  A decelerated rate of change, going from fast to slow.
  Shorthand for `cubic-bezier(0, 0, 1, 1)`.
  */
  Linear

  /*
  An accelerated rate of change, going from slow to fast.
  Shorthand for `cubic-bezier(0.25, 0.1, 0.25, 1)`.
  */
  Ease

  /*
  A decelerated rate of change, going from slow to fast.
  Shorthand for `cubic-bezier(0.42, 0, 1, 1)`.
  */
  EaseIn

  /*
  A decelerated rate of change, going from fast to slow.
  Shorthand for `cubic-bezier(0, 0, 0.58, 1)`.
  */
  EaseOut

  /*
  The rate of change speeds up in the middle.
  Shorthand for `cubic-bezier(0.42, 0, 0.58, 1)`.
  */
  EaseInOut

  /* Shorthand for `steps(1, jump-start)`. */
  StepStart

  /* Shorthand for `steps(1, jump-end)`. */
  StepEnd

  /*
  First two parameters specify the X and Y coordinates of the first control point.
  Last two parameters specify the X and Y coordinates of the last control point.
  All parameters are float values and both X values should be within the range of 0 and 1.
  */
  CubicBezier(Number, Number, Number, Number)

  /*
  Breaks the animation down into a number of equal time intervals.
  The first parameter specifies the number of intervals in the function and should be an integer greater than 0.
  The second parameter, which is optional, specifies the point at which the change of values occur within the interval.
  */
  Steps(Number, Animation.Jump)
}

module Animation.Easing {
  fun toString (easing : Animation.Easing) : String {
    case (easing) {
      Animation.Easing::Linear => "linear"
      Animation.Easing::Ease => "ease"
      Animation.Easing::EaseIn => "ease-in"
      Animation.Easing::EaseOut => "ease-out"
      Animation.Easing::EaseInOut => "ease-in-out"
      Animation.Easing::StepStart => "step-start"
      Animation.Easing::StepEnd => "step-end"

      Animation.Easing::CubicBezier cp1x cp1y cp2x cp2y =>
        "cubic-bezier(" + (cp1x
        |> Number.toString) + ", " + (cp1y
        |> Number.toString) + ", " + (cp2x
        |> Number.toString) + ", " + (cp2y
        |> Number.toString) + ")"

      Animation.Easing::Steps n direction =>
        "steps(" + (n
        |> Number.toString) + ", " + (direction
        |> Animation.Jump.toString) + ")"
    }
  }
}
