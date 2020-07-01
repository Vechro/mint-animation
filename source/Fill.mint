enum Fill {
  None
  Forwards
  Backwards
  Both
  Auto
}

module Fill {
  fun toString (fill : Fill) : String {
    case (fill) {
      Fill::None => "none"
      Fill::Forwards => "forwards"
      Fill::Backwards => "backwards"
      Fill::Both => "both"
      Fill::Auto => "auto"
    }
  }
}
