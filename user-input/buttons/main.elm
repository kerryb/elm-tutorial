module Main exposing (..)

import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = init, view = view, update = update }

-- MODEL

type alias Model =
  Int

init : Model
init = 0

-- UPDATE

type Message
  = Increment
  | Decrement
  | Reset

update : Message -> Model -> Model
update message model =
  case message of
    Increment ->
      model + 1
    Decrement ->
      model - 1
    Reset ->
      0

-- VIEW

view : Model -> Html Message
view model =
  div []
    [ button [ onClick Increment ] [ text "+" ]
    , div [] [ text (toString model) ]
    , button [ onClick Decrement ] [ text "-" ]
    , button [ onClick Reset ] [ text "Reset" ]
    ]
