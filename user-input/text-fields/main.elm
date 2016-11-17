module Main exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import String

main =
  Html.beginnerProgram { model = init, view = view, update = update }

-- MODEL

type alias Model =
  { content : String }

init : Model
init = { content = "" }

-- UPDATE

type Message = Change String

update : Message -> Model -> Model
update message model =
  case message of
    Change newContent -> { model | content = newContent }

-- VIEW

view : Model -> Html Message
view model =
  div []
    [ input [ placeholder "Text to reverse", onInput Change ] []
    , div [] [ text (String.reverse model.content) ]
    ]
