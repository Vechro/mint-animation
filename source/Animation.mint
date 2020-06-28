module Animation {
  fun animate (
    keyframes : Array(Tuple(String, String, Number)),
    duration : Number,
    iterations : String,
    element : Dom.Element
  ) : Void {
    `
    (() => {
      #{element}.animate(
      #{keyframes}.map(kf => ({ [kf[0]]: kf[1], offset: kf[2] })),
      {
        duration: #{encode duration},
        iterations: #{encode iterations}
      });
      })()
    `
  }
}
