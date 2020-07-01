enum Iterations {
  /* Accepts any number greater than or equal to 0 */
  Just(Number)

  /* Infinite amount of iterations */
  Infinity
}

module Iterations {
  fun toString (iterations : Iterations) : String {
    case (iterations) {
      Iterations::Just amount =>
        amount
        |> Number.toString

      Iterations::Infinity => "Infinity"
    }
  }
}
