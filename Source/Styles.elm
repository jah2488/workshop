module Styles exposing (..)

import Html exposing (node, text)
import Common exposing (Position(..))


type alias Styles =
    List ( String, String )


type alias Gradient =
    List Color


type Color
    = Hex String
    | Color String
    | RGBA ( Int, Int, Int, Int )
    | RGB ( Int, Int, Int )


one : Gradient
one =
    [ Hex "69b7eb"
    , Hex "3dbd3"
    , Hex "f4d6db"
    ]


five : Gradient
five =
    [ Hex "b9deed"
    , Hex "efefef"
    ]


dirtyFog : Gradient
dirtyFog =
    [ Hex "8CA6DB"
    , Hex "B993D6"
    ]


toCss : Color -> String
toCss color =
    case color of
        Hex string ->
            "#" ++ string

        RGBA ( red, green, blue, alpha ) ->
            "rgba(" ++ (String.join ", " <| List.map toString [ red, green, blue, alpha ]) ++ ")"

        RGB ( red, green, blue ) ->
            "rgb(" ++ (String.join ", " <| List.map toString [ red, green, blue ]) ++ ")"

        Color str ->
            str


gradient : Gradient -> Styles
gradient colors =
    let
        colorStr =
            List.map toCss colors
                |> String.join ", "

        fallbackColor =
            List.reverse colors
                |> List.head
                |> Maybe.withDefault (Hex "CACACA")
    in
        [ ( "background-color", toCss fallbackColor )
        , ( "background-image", "-webkit-linear-gradient(to left, " ++ colorStr ++ ")" )
        , ( "background-image", "linear-gradient(90deg, " ++ colorStr ++ ")" )
        ]


styleTag css =
    node "style"
        []
        [ text css
        ]


globalCss =
    """
    //Montserrat - Poppins - Muli - Oxygen
  @import url('https://fonts.googleapis.com/css?family=Cabin');

  * {
    box-sizing: border-box;
  }

  html, body {
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    font-family: 'Cabin', Helvetica, sans-serif;
    box-sizing: border-box;
  }

  section div {
    box-sizing: border-box;
  }

  .nav.current {
    text-decoration: underline;
  }
  .nav {
    margin: 0 .15em;
    user-select: none;
  }
  .nav:hover {
    text-decoration: underline;
    cursor: pointer;
  }
  .nav:active {
    color: #ACACAC;
  }

  @keyframes slidein {
    from {
      bottom: -200px;
    }

    to {
      bottom: 0;
    }
  }
"""


globalStyleTag =
    styleTag globalCss


slideShowStyles : Styles
slideShowStyles =
    (gradient dirtyFog)
        ++ [ ( "width", "100%" )
           , ( "height", "100%" )
           , ( "font-size", "2em" )
           , ( "color", "white" )
           , ( "display", "flex" )
           , ( "align-items", "center" )
           , ( "justifyContent", "center" )
           ]


slideStyles : Styles
slideStyles =
    [ ( "flex", "1" )
    , ( "text-align", "center" )
    ]


drawerStyles : Position -> Styles
drawerStyles position =
    [ ( "background", "rgba(50, 50, 50, 0.4)" )
    , ( "width", "100%" )
    , ( "position", "fixed" )
    , ( "left", "0" )
    , ( "bottom", "0" )
    , ( "padding", "0.5em" )
    , ( "height", "65px" )
    , ( "display", "flex" )
    ]
        ++ if position == Open then
            [ ( "animation", "slidein 0.5s ease" ) ]
           else
            [ ( "height", "0" )
            , ( "overflow", "hidden" )
            , ( "padding", "0" )
            ]
