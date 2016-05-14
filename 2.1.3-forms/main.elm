import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main = beginnerProgram { model = init, view = view, update = update }

type alias Model =
  { username: String
  , password: String
  , passwordConfirmation: String
}

model : Model
model = init

init : Model
init =
  { username = ""
  , password = ""
  , passwordConfirmation = ""
  }

type Message
  = Username String
  | Password String
  | PasswordConfirmation String

update : Message -> Model -> Model
update message model =
  case message of
    Username value ->
      {model | username = value}
    Password value ->
      {model | password = value}
    PasswordConfirmation value ->
      {model | passwordConfirmation = value}

view : Model -> Html Message
view model =
  div []
  [ input [placeholder "Username", onInput Username] []
  , input [type' "password", placeholder "Password", onInput Password] []
  , input [type' "password", placeholder "Confirm password", onInput PasswordConfirmation] []
  , validation model
  ]

validation : Model -> Html Message
validation model =
  let
    (colour, message) =
      if model.password == model.passwordConfirmation then
        ("green", "Password OK")
      else
        ("red", "Passwords do not match")
  in
     div [style [("color", colour)]] [text message]
