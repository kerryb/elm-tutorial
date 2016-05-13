import Html exposing (Html, div, text, input)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import String

main = beginnerProgram { model = init, view = view, update = update }

type alias Model = {value: String}

model : Model
model = init

init : Model
init = {value = ""}

type Message = Change String

update : Message -> Model -> Model
update message model =
  case message of
    Change newValue ->
      {model | value = newValue}

view : Model -> Html Message
view model =
  div []
    [ input [placeholder "type some text", onInput Change] []
    , div [] [ text (String.reverse model.value) ]
    ]
