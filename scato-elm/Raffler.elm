import Time exposing (Time)
import Random
import Keyboard
import Graphics.Element exposing (..)
import Text
import Window

-- read names from separate module
import Names

-- create a stream of milliseconds to use for seeding
time : Signal Time
time =
  Time.every Time.millisecond

-- make sure an integer is within bounds of a list
modulo : List a -> Int -> Int
modulo x y =
  y % (List.length x)

-- find an element in a list
find : List a -> Int -> Maybe a
find x y =
  x |> List.drop y
    |> List.head

-- create a stream of random names
name : Signal String
name =
  let generator = Random.int 0 Random.maxInt
  in time |> Signal.map Time.inMilliseconds
          |> Signal.map round
          |> Signal.map Random.initialSeed
          |> Signal.map (Random.generate generator)
          |> Signal.map fst
          |> Signal.map (modulo Names.list)
          |> Signal.map (find Names.list)
          |> Signal.map (Maybe.withDefault "")

-- create a stream that alternates between True and False
pause : Signal Bool
pause =
  Keyboard.space |> Signal.foldp xor False

-- create a stream of random names that can be paused by pressing space
-- and can be resumed by pressing space again
raffle : Signal String
raffle =
  name |> Signal.map2 (,) pause
       |> Signal.filter (\(x, y) -> not x) (False, "")
       |> Signal.map (\(x, y) -> y)

-- create a container with a text in the middle
view : Int -> Int -> String -> Element
view w h x =
  x |> Text.fromString
    |> Text.height 80
    |> centered
    |> container w h middle

-- show the raffle in the middle of the window
main : Signal Element
main =
  raffle |> Signal.map3 (,,) Window.width Window.height
         |> Signal.map (\(w, h, x) -> view w h x)

