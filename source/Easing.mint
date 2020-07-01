/* TODO: Make these const? */
enum Easing {
  /* Shorthand for cubic-bezier(0, 0, 1, 1) */
  Linear

  /* Shorthand for cubic-bezier(0.25, 0.1, 0.25, 1) */
  Ease

  /* Shorthand for cubic-bezier(0.42, 0, 1, 1) */
  EaseIn

  /* Shorthand for cubic-bezier(0, 0, 0.58, 1) */
  EaseOut

  /* Shorthand for cubic-bezier(0.42, 0, 0.58, 1) */
  EaseInOut

  /* Shorthand for `steps(1, jump-start)` */
  StepStart

  /* Shorthand for `steps(1, jump-end)` */
  StepEnd

  /* Must be float values in range [0, 1] */
  CubicBezier(Number, Number, Number, Number)

  /* Must be a integer value greater than 0 */
  Steps(Number, Jump)
}

module Easing {
  fun toString (easing : Easing) : String {
    case (easing) {
      Easing::Linear => "linear"
      Easing::Ease => "ease"
      Easing::EaseIn => "ease-in"
      Easing::EaseOut => "ease-out"
      Easing::EaseInOut => "ease-in-out"
      Easing::StepStart => "step-start"
      Easing::StepEnd => "step-end"

      /* TODO: Limit args to range [0, 1] */
      Easing::CubicBezier cp1x cp1y cp2x cp2y =>
        "cubic-bezier(" + (cp1x
        |> Number.toString) + ", " + (cp1y
        |> Number.toString) + ", " + (cp2x
        |> Number.toString) + ", " + (cp2y
        |> Number.toString) + ")"

      Easing::Steps n direction =>
        "steps(" + (n
        |> Number.toString) + ", " + (direction
        |> Jump.toString) + ")"
    }
  }
}
