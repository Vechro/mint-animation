enum Easing {
  Linear
  Ease
  EaseIn
  EaseOut
  EaseInOut
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

  /* Start time, progress in time in range [0, 1], end time */
  fun linear (start : Number, t : Number, end : Number) {
    (1.0 - t) * start + t * end
  }

  fun cubic (start : Number, t : Number, end : Number) {
    cube * start + (1 - cube) * end
  } where {
    cube =
      Math.pow((1 - t), 3)
  }

  fun easeOutBack (start : Number, t : Number, end : Number) {
    (1 - t) * start + t2 * end
  } where {
    c1 =
      1.70158

    c3 =
      c1 + 1

    t2 =
      1 + c3 * Math.pow(t - 1, 3) + c1 * Math.pow(t - 1, 2)
  }
}
