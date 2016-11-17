module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import List
import Regex

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model =
  { name : String
  , age : String
  , password : String
  , passwordConfirmation : String
  , errors : List String
  }

model : Model
model =
  Model "" "" "" "" []

-- UPDATE

type Message
  = Name String
  | Age String
  | Password String
  | PasswordConfirmation String
  | Submit

update : Message -> Model -> Model
update message model =
  case message of
    Name name ->
      { model | name = name }
    Age age ->
      { model | age = age }
    Password password ->
      { model | password = password }
    PasswordConfirmation passwordConfirmation ->
      { model | passwordConfirmation = passwordConfirmation }
    Submit ->
      validate model

validate : Model -> Model
validate model =
  { model
    | errors =
      List.concat
        [ (ageErrors model)
        , (passwordLengthErrors model)
        , (passwordConfirmationErrors model)
        , (passwordLowerCaseLetterErrors model)
        , (passwordUpperCaseLetterErrors model)
        , (passwordDigitErrors model)
        ]
  }

ageErrors : Model -> List String
ageErrors model =
  case String.toInt model.age of
    Ok age ->
      if age >= 0 then
        []
      else
        [ "Age must be positive" ]
    Err _ ->
      [ "Age must be a number" ]

passwordLengthErrors : Model -> List String
passwordLengthErrors model =
  if String.length model.password >= 8 then
    []
  else
    [ "Password must be at least eight characters" ]

passwordConfirmationErrors : Model -> List String
passwordConfirmationErrors model =
  if model.password == model.passwordConfirmation then
    []
  else
    [ "Passwords don't match" ]

passwordLowerCaseLetterErrors : Model -> List String
passwordLowerCaseLetterErrors model =
  if Regex.contains (Regex.regex "[a-z]") model.password then
    []
  else
    [ "Password must contain a lower case letter" ]

passwordUpperCaseLetterErrors : Model -> List String
passwordUpperCaseLetterErrors model =
  if Regex.contains (Regex.regex "[A-Z]") model.password then
    []
  else
    [ "Password must contain an upper case letter" ]

passwordDigitErrors : Model -> List String
passwordDigitErrors model =
  if Regex.contains (Regex.regex "\\d") model.password then
    []
  else
    [ "Password must contain a digit" ]

-- VIEW

view : Model -> Html Message
view model =
  div []
    [ input [ placeholder "Name", onInput Name ] []
    , input [ placeholder "Age", onInput Age ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Password confirmation", onInput PasswordConfirmation ] []
    , input [ type_ "submit", onClick Submit ] []
    , (errorMessages model)
    ]

errorMessages : Model -> Html Message
errorMessages model =
  ul [] (List.map errorMessage model.errors)

errorMessage : String -> Html Message
errorMessage error =
  li [ style [ ( "color", "red" ) ] ] [ text error ]
