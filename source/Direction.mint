enum Animation.Directions {
  /* The animation runs forwards, from beginning to end, in the way we experience the flow of time. */
  Normal

  /* The animation runs backwards. */
  Reverse

  /* The animation switches direction after each iteration, starting with forward. */
  Alternate

  /* The animation switches direction after each iteration, starting with reverse. */
  AlternateReverse
}

module Animation.Directions {
  fun toString (direction : Animation.Directions) : String {
    case (direction) {
      Animation.Directions::Normal => "normal"
      Animation.Directions::Reverse => "reverse"
      Animation.Directions::Alternate => "alternate"
      Animation.Directions::AlternateReverse => "alternate-reverse"
    }
  }
}
