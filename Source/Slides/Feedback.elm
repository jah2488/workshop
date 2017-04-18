module Slides.Feedback exposing (feedback)

import Html exposing (Html, text)
import Common exposing (..)


feedback : Slide
feedback =
    { title = "Feedback"
    , content = content
    }


content : State -> Html Msg
content model =
    text "Hi"
