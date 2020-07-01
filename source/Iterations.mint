enum Animation.Iterations {
  /*
  Plays the animation n amount of times.
  The number should be a value greater than or equal to 0.
  */
  Just(Number)

  /* Infinite amount of iterations. */
  Infinity
}

module Animation.Iterations {
  fun toString (iterations : Animation.Iterations) : String {
    case (iterations) {
      Animation.Iterations::Just amount =>
        amount
        |> Number.toString

      Animation.Iterations::Infinity => "Infinity"
    }
  }
}
