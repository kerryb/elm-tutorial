import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import List

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
  validatePasswordsPatch { model | errors = [] }

validatePasswordsPatch : Model -> Model
validatePasswordsPatch model =
  if model.password == model.passwordConfirmation then
     model
  else
    { model | errors = "Passwords don't match" :: model.errors }

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
      if List.isEmpty model.errors then
        ("green", "OK")
      else
        ("red", String.join "; " model.errors)
  in
    div [style [("color", colour)] ] [text message]
