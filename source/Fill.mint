enum Animation.Fill {
  /* The animation's effects are only visible while the animation is iterating or its playhead is positioned over an iteration. */
  None

  /* The affected element will continue to be rendered in the state of the final animation frame. */
  Forwards

  /* The animation's effects should be reflected by the element(s) state prior to playing. */
  Backwards

  /*
  Combining the effects of both Animation.Fill::Forwards and Animation.Fill::Backwards:
  The animation's effects should be reflected by the element(s) state prior to playing and retained after the animation has completed playing.
  */
  Both

  /* Picks either Animation.Fill::Both or Animation.Fill::None, whichever is more appropriate. */
  Auto
}

module Animation.Fill {
  fun toString (fill : Animation.Fill) : String {
    case (fill) {
      Animation.Fill::None => "none"
      Animation.Fill::Forwards => "forwards"
      Animation.Fill::Backwards => "backwards"
      Animation.Fill::Both => "both"
      Animation.Fill::Auto => "auto"
    }
  }
}
