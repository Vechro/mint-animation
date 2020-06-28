component Main {
  fun main : Void {
    Maybe.withDefault(Dom.createElement("div"), Dom.getElementById("test"))
    |> Animation.animate(
      [
        {"transform", "rotate(0)", 0},
        {"transform", "rotate(15deg)", 0.3},
        {"transform", "rotate(360deg)", 1}
      ],
      1000,
      "Infinity")
  }

  fun render : Html {
    <div id="test" onClick={main}>
      "text"
    </div>
  }
}
