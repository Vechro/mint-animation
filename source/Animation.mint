module Animation {
  fun animate (
    keyframes : Array(Tuple(Array(Tuple(String, String)), Number)),
    duration : Number,
    iterations : String,
    element : Dom.Element
  ) : Void {
    `
    (() => {
      console.log(#{keyframes})
      #{element}.animate(
      #{keyframes}.map(kf => ({ [kf[0][0][0]]: kf[0][0][1], offset: kf[1] })),
      {
        duration: #{encode duration},
        iterations: #{encode iterations}
      });
    })()
    `
  }
}
