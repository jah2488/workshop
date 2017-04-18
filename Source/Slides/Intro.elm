module Slides.Intro exposing (intro)

import Html exposing (..)
import Common exposing (..)


intro : Slide
intro =
    { title = "Improving Your Teams Through Improved Communication"
    , content = content
    }


content : State -> Html Msg
content model =
    div []
        [ h1 [] [ text "A Talk" ]
        , h3 [] [ text "by me" ]
        , h5 [] [ text "Justin Herrick" ]
        ]
