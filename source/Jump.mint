/* Effectively determines which step to "eat" */
enum Jump {
  /* Equivalent to `start` and `jump-start` */
  Start

  /* Equivalent to `end` and `jump-end` */
  End

  /* Equivalent to `jump-none` */
  None

  /* Equivalent to `jump-both` */
  Both
}

module Jump {
  fun toString (direction : Jump) : String {
    case (direction) {
      Jump::Start => "start"
      Jump::End => "end"
      Jump::None => "jump-none"
      Jump::Both => "jump-both"
    }
  }
}
