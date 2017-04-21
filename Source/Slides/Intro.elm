module Slides.Intro exposing (intro)

import Html exposing (..)
import Common exposing (..)


intro : Slide
intro =
    { title = "Improving Your Teams Through Improved Communication"
    , content = content
    , duration = 0
    , targetDuration = 10
    }


content : State -> Html Msg
content model =
    div []
        [ h1 [] [ text "A Talk" ]
        , h3 [] [ text "by me" ]
        , h5 [] [ text "Justin Herrick" ]
        ]
