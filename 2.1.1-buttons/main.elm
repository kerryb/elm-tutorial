import Html exposing (Html, div, text, button)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

main = beginnerProgram { model = init, view = view, update = update }

type alias Model = {value: Int}

model : Model
model = init

init : Model
init = {value = 0}

type Message = Increment | Decrement | Reset

update : Message -> Model -> Model
update message model =
  case message of
    Increment ->
      {model | value = model.value + 1}
    Decrement ->
      {model | value = model.value - 1}
    Reset ->
      init

view : Model -> Html Message
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model.value) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Reset ] [ text "Reset" ]
    ]
