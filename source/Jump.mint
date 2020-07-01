/* Effectively determines which step to "eat" */
enum Animation.Jump {
  /* Equivalent to `start` and `jump-start` */
  Start

  /* Equivalent to `end` and `jump-end` */
  End

  /* Equivalent to `jump-none` */
  None

  /* Equivalent to `jump-both` */
  Both
}

module Animation.Jump {
  fun toString (direction : Animation.Jump) : String {
    case (direction) {
      Animation.Jump::Start => "start"
      Animation.Jump::End => "end"
      Animation.Jump::None => "jump-none"
      Animation.Jump::Both => "jump-both"
    }
  }
}
