module Slides.Limits exposing (limitsSlides)

import Html exposing (..)
import Common exposing (..)


empty : State -> Html Msg
empty =
    (\_ -> span [] [])


limitsSlides : List Slide
limitsSlides =
    [ newSlide "The Limits of Our Communication" 60 empty
    , newSlide "Understanding Our Own Limitations"
        60
        (\_ ->
            div []
                [ p [] [ text "By Our Perspective" ]
                , p [] [ text "By Our Knowledge" ]
                , p [] [ text "By Our Emotional State" ]
                , p [] [ text "By The Language(s) We Use" ]
                ]
        )
    , newSlide "Our background colors the way we see" 45 (\_ -> h5 [] [ text "Literally" ])
    , newSlide "Our knowledge can impede our communication" 30 empty
    , newSlide "The Monad Problem" 90 empty
    , newSlide "The Senior Developer Dillema" 90 empty
    , newSlide "Our ability to express is tied to our emotional state" 50 empty
    , newSlide "Non Verbal Communication" 30 empty
    , newSlide "Has a Negativity Bias" 30 empty
    , newSlide "Always convey expectations cleary" 30 empty
    , newSlide "Be Prepared to Take Converastaions Offline When Needed" 30 empty
    , newSlide "Identify Strengths" 30 empty
    , newSlide "Suggest Solutions" 40 empty
    , newSlide "Explain Context and Reasoning behind decisions or statements" 45 empty
    , newSlide "Establish Rituals 🙅" 60 empty
    , newSlide "Be overly emotive" 30 empty
    ]



-- ++ [ newSlide "HANDS ON TIME"
--         800
--         (\_ ->
--             h4 [] [ text "Blind Pair Programming" ]
--         )
--      -- , newSlide "Communication Limits Takeaways" 90 (\_ -> div [] [ text "Coming soon" ])
--    ]
