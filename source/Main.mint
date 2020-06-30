component Main {
  fun componentDidMount : Promise(Never, Void) {
    case (anim) {
      Result::Err => Promise.never()
      Result::Ok result => Promise.never()
    }
  } where {
    el =
      Maybe.withDefault(Dom.createElement("div"), Dom.getElementById("test"))

    anim =
      with Animation {
        create()
        |> step([{"transform", "rotate(0)"}])
        |> withOffset(0.1)
        |> step([{"transform", "rotate(15deg) translateX(300px)"}])
        |> step([{"transform", "rotate(360deg)"}])
        |> duration(3000)
        |> iterations("Infinity")
        |> animate(el)
      }
  }

  style test {
    margin: 4em;
    font-family: "Segoe UI", sans-serif;
    font-size: 2em;
    width: 50%;
  }

  fun render : Html {
    <div::test
      id="test">

      "Test"

    </div>
  }
}
