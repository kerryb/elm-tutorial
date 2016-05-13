import Html exposing (Html, div, text, button)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

main = beginnerProgram { model = model, view = view, update = update }

type alias Model = {value: Int}

model : Model
model = {value = 0}

type Message = Increment | Decrement

update : Message -> Model -> Model
update message model =
  case message of
    Increment -> {model | value = model.value + 1}
    Decrement -> {model | value = model.value - 1}

view : Model -> Html Message
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model.value) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
