enum Direction {
  Normal
  Reverse
  Alternate
  AlternateReverse
}

module Direction {
  fun toString (direction : Direction) : String {
    case (direction) {
      Direction::Normal => "normal"
      Direction::Reverse => "reverse"
      Direction::Alternate => "alternate"
      Direction::AlternateReverse => "alternate-reverse"
    }
  }
}
