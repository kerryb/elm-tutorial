import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Regex exposing (regex, contains)

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
  , strengthCheck model
  ]

validation : Model -> Html Message
validation model =
  let
    (colour, message) =
      if model.password == model.passwordConfirmation then
        ("green", "OK")
      else
        ("red", "Passwords do not match")
  in
     div [style [("color", colour)]] [text message]

strengthCheck : Model -> Html Message
strengthCheck model =
  let
    strength = passwordStrength model.password
    (colour, message) =
      if strength == 0 then
        ("red", "weak")
      else if strength == 1 then
        ("orange", "medium")
      else if strength == 2 then
        ("yellow", "OK")
      else
        ("green", "strong")
  in
     div [style [("color", colour)]] [text "Password strength: ", text message]

passwordStrength: String -> Int
passwordStrength password =
  if String.length password < 8 then
    0
  else
    mixedCaseScore password + hasNumberScore password + hasSymbolScore password

mixedCaseScore: String -> Int
mixedCaseScore password =
  if contains (regex "[a-z]") password && contains (regex "[A-Z]") password then
    1
  else
    0

hasNumberScore: String -> Int
hasNumberScore password =
  if contains (regex "\\d") password then
    1
  else
    0

hasSymbolScore: String -> Int
hasSymbolScore password =
  if contains (regex "\\W") password then
    1
  else
    0
