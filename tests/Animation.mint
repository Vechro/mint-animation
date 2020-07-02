component Test.Animation {
  property config : Animation.Configuration
  state errorMessage : String = ""
  state el : Dom.Element = Dom.createElement("div")

  fun componentDidMount : Promise(Never, Void) {
    sequence {
      case (elMaybe) {
        Maybe::Nothing => next { errorMessage = "element not found" }
        Maybe::Just el => next { el = el }
      }

      anim =
        config
        |> Animation.animate(el)

      next {  }
    } catch Animation.Error => error {
      case (error) {
        Animation.Error::Unknown => next { errorMessage = "unknown error" }
        Animation.Error::TypeError => next { errorMessage = "type error" }
        Animation.Error::SyntaxError => next { errorMessage = "syntax error" }
        Animation.Error::NotSupportedError => next { errorMessage = "not supported error" }
        Animation.Error::InvalidStateError => next { errorMessage = "invalid state error" }
        Animation.Error::AbortError => next { errorMessage = "abort error" }
        Animation.Error::HierarchyRequestError => next { errorMessage = "hierarchy request error" }
      }
    }
  } where {
    elMaybe =
      Dom.getElementById("test")
  }

  fun render : Html {
    <div>
      <error>
        <{ errorMessage }>
      </error>

      <div id="test"/>
    </div>
  }
}

suite "Animation" {
  test "No animation errors" {
    with Test.Html {
      <Test.Animation
        config={
          Animation.create()
          |> Animation.step([{"transform", "rotate(0)"}])
          |> Animation.withOffset(0.1)
          |> Animation.step([{"transform", "rotate(15deg) translateX(10em)"}])
          |> Animation.step([{"transform", "rotate(360deg)"}])
          |> Animation.duration(100)
          |> Animation.fill(Animation.Fill::Forwards)
          |> Animation.iterations(Animation.Iterations::Just(1))
        }/>
      |> start()
      |> assertTextOf("error", "")
    }
  }
}
