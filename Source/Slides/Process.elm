module Slides.Process exposing (processSlides)

import Html exposing (..)
import Common exposing (..)


empty : State -> Html Msg
empty =
    (\_ -> span [] [])


processSlides : List Slide
processSlides =
    [ newSlide "Process As Communication" 60 empty
    , newSlide "What We Write Down Says A Lot" 60 empty
    , newSlide "Decrease Your Bus Factor: Write It Down" 45 (\_ -> h5 [] [ text "Literally" ])
    , newSlide "Procedure Can Become Your Scapegoat" 30 empty
    , newSlide "Don't blame the person after a failure" 90 empty
    , newSlide "Ask how THE PROCESS allowed for that failure to occur" 90 empty
    , newSlide "Team Procedures should be enforced by the whole team" 50 empty
    , newSlide "However, the process should be every changing" 30 empty
    , newSlide "Adapt it to fit you and your team" 30 empty
    , newSlide "Reevaluate on a regular basis to see if past decisions are not relevant anymore" 30 empty
    , newSlide "Always record the WHY" 30 empty
    , newSlide "Empower team members by giving them the tools and knowledge " 30 empty
    , newSlide "Don't put babies in the kitchen" 40 empty
    , newSlide "Its okay to have a menu" 45 empty
    , newSlide "Establish Rituals 🙅" 60 empty
    , newSlide "HANDS ON TIME" 800 (\_ -> h4 [] [ text "Building a Team Process" ])
    , newSlide "Communication As Process Takeaways" 90 (\_ -> div [] [ text "Coming soon" ])
    ]
