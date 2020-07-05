# mint-animation

A wrapper around [element.animate()](https://developer.mozilla.org/en-US/docs/Web/API/Element/animate) for Mint.

## Include it in your project

To include the library in your project, you need to add it to your list of dependencies in your `mint.json`

```json
  "dependencies": {
      "mint-animation": {
          "repository": "https://github.com/Vechro/mint-animation.git",
          "constraint": "0.1.0 <= v < 1.0.0"
      }
  }
```

## Usage with an example

You must first create the record which stores all the animation data by calling the function `Animation.create()` which you can then pipe into other Animation functions which take an `Animation.Configuration` as their last argument. Consult the docs for more information.

```mint
Animation.create()
|> Animation.step([{"transform", "rotate(0)"}, {"color", "#fdb"}])
|> Animation.step([{"transform", "rotate(360deg)"}, {"color", "#111"}])
|> Animation.duration(1000)
|> Animation.iterations(Animation.Iterations::Infinity)
|> Animation.animate(Dom.createElement("div"))
```

Here we first create the Animation record and then add animation steps as tuples in an array. The first item in the tuple is the CSS property and the second item is the value for that property.
In the next step we modify the same CSS properties. We also specify a duration of 1000ms for the whole animation.

Also notice how we give our animation infinite iterations with an enum. There's quite a few enums in place to try and stop you from making any mistakes in your inputs. The functions which accept enums were carefully chosen to make sure they don't restrict your freedom with animations in any way.

Lastly we call `Animation.animate` and provide an element on which to animate it on.

However the last function returns a different type, a `Result(Animation.Error, Animation)` because it can fail as the library is very permissive on what you can pass to that function because it's far more reasonable to let the underlying Web Animations API figure out how to interpret your input.

After you destructure the `Result` you can call `Animation`-specific functions on it such as `Animation.pause()`.

## Additional notes

As the animation spec is still in the draft stage, you should take a look at the Mozilla docs regarding Web Animation API to see what kind of inputs various browsers accept and how they're interpreted. For example, some browsers can't do [implicit keyframes](https://developer.mozilla.org/en-US/docs/Web/API/Element/animate#Implicit_tofrom_keyframes) (such as when you only have one `Animation.step`) which will cause an exception (this is also a part of why `Animation.animate` returns a result).