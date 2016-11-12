import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import List
import Regex

main = App.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordConfirmation : String
  , errors : List String
  }
model : Model
model = Model "" "" "" []

-- UPDATE

type Message
  = Name String
  | Password String
  | PasswordConfirmation String

update : Message -> Model -> Model
update message model =
  let
    updatedModel = case message of
      Name name -> { model | name = name }
      Password password -> { model | password = password }
      PasswordConfirmation passwordConfirmation -> { model | passwordConfirmation = passwordConfirmation }
  in
    validate updatedModel

validate : Model -> Model
validate model =
  { model | errors =
    List.concat
      [ (passwordLengthErrors model)
      , (passwordConfirmationErrors model)
      , (passwordLowerCaseLetterErrors model)
      , (passwordUpperCaseLetterErrors model)
      , (passwordDigitErrors model)
      ]
  }

passwordLengthErrors : Model -> List String
passwordLengthErrors model =
  if String.length model.password >= 8 then
     []
  else
    ["Password must be at least eight characters"]

passwordConfirmationErrors : Model -> List String
passwordConfirmationErrors model =
  if model.password == model.passwordConfirmation then
     []
  else
    ["Passwords don't match"]

passwordLowerCaseLetterErrors : Model -> List String
passwordLowerCaseLetterErrors model =
  if Regex.contains (Regex.regex "[a-z]") model.password then
     []
  else
    ["Password must contain a lower case letter"]

passwordUpperCaseLetterErrors : Model -> List String
passwordUpperCaseLetterErrors model =
  if Regex.contains (Regex.regex "[A-Z]") model.password then
     []
  else
    ["Password must contain an upper case letter"]

passwordDigitErrors : Model -> List String
passwordDigitErrors model =
  if Regex.contains (Regex.regex "\\d") model.password then
     []
  else
    ["Password must contain a digit"]

-- VIEW

view : Model -> Html Message
view model =
  div []
    [ input [ placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Password confirmation", onInput PasswordConfirmation ] []
    , (errorMessages model)
    ]

errorMessages : Model -> Html Message
errorMessages model =
  ul [] (List.map errorMessage model.errors)

errorMessage : String -> Html Message
errorMessage error =
  li [style [("color", "red")] ] [text error]
