component Main {
  fun main : Animation {
    with Animation {
      create()
      |> step([{"transform", "rotate(0)"}])
      |> withOffset(0.3)
      |> step([{"transform", "rotate(15deg)"}])
      |> step([{"transform", "rotate(360deg)"}])
      |> duration(3000)
      |> iterations("Infinity")
      |> animate(el)
    }
  } where {
    el =
      Maybe.withDefault(Dom.createElement("div"), Dom.getElementById("test"))
  }

  fun render : Html {
    <div
      id="test"
      onClick={main}>

      "text"

    </div>
  }
}
