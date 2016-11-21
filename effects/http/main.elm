module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Json

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { topic : String
  , url : String
  }

-- UPDATE

type Message
  = Replace
  | NewImage (Result Http.Error String)

update : Message -> Model -> ( Model, Cmd Message )
update message model =
  case message of
    Replace -> (model, getRandomGif model.topic)
    NewImage (Ok newUrl) -> ( {model | url = newUrl}, Cmd.none )
    NewImage (Err _) -> (model, Cmd.none)

getRandomGif : String -> Cmd Message
getRandomGif topic =
  let
    url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    request = Http.get url extractGitUrl
  in
    Http.send NewImage request

extractGitUrl : Json.Decoder String
extractGitUrl = Json.at ["data", "image_url"] Json.string

-- VIEW

view : Model -> Html Message
view model =
  div []
    [ h2 [] [ text model.topic ]
    , button [ onClick Replace ] [ text "Replace" ]
    , div []
    [ img [ src model.url ] []
    ]
  ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Message
subscriptions model =
  Sub.none

-- INIT

init : ( Model, Cmd Message )
init =
  ( Model "cats" "start.png", Cmd.none )
