module Slides.Feedback exposing (feedback)

import Html exposing (Html, text)
import Common exposing (..)


feedback : Slide
feedback =
    newSlide "Feedback" (\model -> text "hi") 10
