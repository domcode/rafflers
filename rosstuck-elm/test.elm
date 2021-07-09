import Html exposing (h2, textarea, br, button, ul, li, text, div, Html)
import Html.Events exposing (onClick, onInput)
import List exposing (map)
import String exposing (split, trim)
import Random
import Random.Extra exposing (sample)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

type alias Name = String
type alias Names = List Name
type alias Model =
  { contestants : Names
  , winner : Maybe Name
  }

init : (Model, Cmd msg)
init = (Model [] Nothing, Cmd.none)

type Msg = GatherNames Names | StartRaffle | PickWinner (Maybe Name)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GatherNames allNames ->
      ({model | contestants = allNames, winner = Nothing}, Cmd.none)
    StartRaffle ->
      (model, Random.generate PickWinner (sample model.contestants))
    PickWinner nameOfWinner ->
      ({model | winner = nameOfWinner}, Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text "DomCode Elm Raffler"]
    , textarea [onInput splitNames] []
    , br [] []
    , button [onClick StartRaffle] [text "And the winner is..."]
    , br [] []
    , showWinner model
    ]

splitNames : String -> Msg
splitNames input =
  if (trim input == "") then
    GatherNames []
  else
    GatherNames (split "\n" (trim input))

showWinner : Model -> Html Msg
showWinner model =
  case model.winner of
    Just winner -> text winner
    Nothing -> text "No Winner yet"
