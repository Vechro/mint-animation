component Main {
  fun main : Void {
    Maybe.withDefault(Dom.createElement("div"), Dom.getElementById("test"))
    |> Animation.animate(
      [
        {[{"transform", "rotate(0)"}, {"color", "#000"}], 0},
        {[{"transform", "rotate(15deg)"}], 0.3},
        {[{"transform", "rotate(360deg)"}, {"color", "#3fa"}], 1}
      ],
      3000,
      "Infinity")
  }

  fun render : Html {
    <div id="test" onClick={main}>
      "text"
    </div>
  }
}
