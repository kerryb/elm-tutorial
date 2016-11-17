module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random
import Die exposing (die)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { dieFaces : List Int
  }

-- UPDATE

type Message
  = Roll
  | NewFaces (List Int)

update : Message -> Model -> ( Model, Cmd Message )
update message model =
  case message of
    Roll ->
      ( model, newFace model )
    NewFaces faces ->
      ( { model | dieFaces = faces }, Cmd.none )

newFace : Model -> Cmd Message
newFace model =
  Random.generate NewFaces (Random.list (List.length model.dieFaces) (Random.int 1 6))

-- VIEW

view : Model -> Html Message
view model =
  div [ style [ ( "margin", "5px" ) ] ]
    [ div []
      (List.map die model.dieFaces)
    , div []
      [ button [ style [ ( "margin", "5px" ) ], onClick Roll ] [ text "Roll" ]
      ]
    ]

die : Int -> Html Message
die dieFace =
  span [ style [ ( "padding", "5px" ) ] ] [ Die.die dieFace ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Message
subscriptions model =
  Sub.none

-- INIT

init : ( Model, Cmd Message )
init =
  ( Model [ 6, 6, 6 ], Cmd.none )
