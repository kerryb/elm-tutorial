import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random
import Die exposing (die)

main = App.program { init = init
                   , view = view
                   , update = update
                   , subscriptions = subscriptions
                   }

-- MODEL

type alias Model =
  { dieFace : Int
  }


-- UPDATE

type Message = Roll
             | NewFace Int

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    Roll -> (model, Random.generate NewFace (Random.int 1 6))
    NewFace face -> ({model | dieFace = face }, Cmd.none)


-- VIEW

view : Model -> Html Message
view model =
  div [style [ ("margin", "5px") ] ]
  [ div []
    [ span [style [ ("padding", "5px") ] ]
      [ die model.dieFace
      ]
    , span [style [ ("padding", "5px") ] ]
      [ die model.dieFace
      ]
    ]
  , div []
    [ button [ style [ ("margin", "5px") ], onClick Roll ] [ text "Roll" ]
    ]
  ]


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Message
subscriptions model =
  Sub.none


-- INIT

init : (Model, Cmd Message)
init =
  (Model 1, Cmd.none)
