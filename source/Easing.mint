/*
'ease': cubic(0.25, 0.1, 0.25, 1),
'ease-in': cubic(0.42, 0, 1, 1),
'ease-out': cubic(0, 0, 0.58, 1),
'ease-in-out': cubic(0.42, 0, 0.58, 1),
'step-start': step(1, Start),
'step-middle': step(1, Middle),
'step-end': step(1, End)
*/

/* TODO: Make these const */
enum Easing {
  Linear
  Ease
  EaseIn
  EaseOut
  EaseInOut
  StepStart
  StepMiddle
  StepEnd
}

module Easing {
  /*
  fun easingToValue (easing : Easing) : String {
    case (easing) {
      Easing::Linear => "linear"
      Easing::Ease => "ease"
      Easing::EaseIn => "ease-in"
      Easing::EaseOut => "ease-out"
      Easing::EaseInOut => "ease-in-out"
    }
  }
  */
}
