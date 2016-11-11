import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String

main = App.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordConfirmation : String
  }
model : Model
model = Model "" "" ""

-- UPDATE

type Message
  = Name String
  | Password String
  | PasswordConfirmation String

update : Message -> Model -> Model
update message model =
  case message of
    Name name -> { model | name = name }
    Password password -> { model | password = password }
    PasswordConfirmation passwordConfirmation -> { model | passwordConfirmation = passwordConfirmation }

-- VIEW

view : Model -> Html Message
view model =
  div []
    [ input [ placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Password confirmation", onInput PasswordConfirmation ] []
    , viewValidation model
    ]

viewValidation : Model -> Html Message
viewValidation model =
  let
    (colour, message) =
      if model.password == model.passwordConfirmation then
        ("green", "Cool")
      else
        ("red", "Nope")
  in
    div [style [("color", colour)] ] [text message]
