module Die exposing (die)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Dict

die : Int -> Html.Html msg
die number =
  svg
    [ version "1.1", x "0", y "0", viewBox "0 0 100 100", width "100", height "100"
    ]
    ( [ rect [ fill "#f00", x "0", y "0", width "100", height "100", rx "10", ry "10" ] []
      ]
      ++ (spots number)
    )

spots : Int -> List (Svg msg)
spots sides =
  let
      positionsByNumber = Dict.fromList
        [ (1, [ ("50", "50")])
        , (2, [ ("25", "25"), ("75", "75") ])
        , (3, [ ("25", "25"), ("50", "50"), ("75", "75") ])
        , (4, [ ("25", "25"), ("25", "75"), ("75", "25"), ("75", "75") ])
        , (5, [ ("25", "25"), ("25", "75"), ("50", "50"), ("75", "25"), ("75", "75") ])
        , (6, [ ("25", "25"), ("25", "75"), ("25", "50"), ("75", "50"), ("75", "25"), ("75", "75") ])
        ]
  in
     case Dict.get sides positionsByNumber of
       Just (positions) -> List.map spot positions
       Nothing -> []

spot : (String, String) -> Svg msg
spot (x, y) =
  circle [ fill "#fff", cx x, cy y, r "10" ] []
