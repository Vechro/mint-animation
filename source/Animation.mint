module Animation {
  fun animate (
    keyframes : Array(Tuple(Array(Tuple(String, String)), Number)),
    duration : Number,
    iterations : String,
    element : Dom.Element
  ) : Void {
    `
    (() => {
      const mapped = #{keyframes}.map(function ([settings,val]) {
        const item = {}
        settings.forEach(function ([key, val]) {
          item[key] = val
        })

        return item
      });

      #{element}.animate(
        mapped,
        {
          duration: #{duration},
          iterations: #{iterations}
        }
      );
    })()
    `
  }
}
