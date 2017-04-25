module Slides.Intro exposing (intro, introSlides)

import Html exposing (..)
import Common exposing (..)


intro : Slide
intro =
    newSlide "Building Better Teams Through Communication" 30 content


content : State -> Html Msg
content model =
    div []
        [ h2 [] [ text "The Workshop" ]
        , h3 [] [ text "by me" ]
        , h5 [] [ text "Justin Herrick" ]
        ]


introSlides : List Slide
introSlides =
    [ intro
    , newSlide "About Me"
        30
        (\_ ->
            div []
                [ h2 []
                    [ text "Justin Herrick" ]
                , p [] [ text "Rails Developer" ]
                , p [] [ text "Consultant" ]
                , p [] [ text "Teacher" ]
                , p [] [ text "Person" ]
                ]
        )
    , newSlide "About Lunar Collective"
        30
        (\_ ->
            div []
                [ h4 [] [ text "A Custom Software and Business Consultancy" ]
                , p [] [ text "Custom Software" ]
                , p [] [ text "Project Recovery" ]
                , p [] [ text "Onsite training" ]
                , p [] [ text "Remote mentoring" ]
                , p [] [ text "Custom Apprenticeships" ]
                ]
        )
    , newSlide "About This Workshop"
        60
        (\_ ->
            div []
                [ p [] [ text "This should be a conversation" ]
                , p [] [ text "Questions are encouraged" ]
                , p [] [ text "Honesty is important" ]
                ]
        )
    , newSlide "Show of Hands" 45 (\_ -> span [] [])
    , newSlide "Why Communication Matters"
        30
        (\_ ->
            div []
                [ h4 [] [ text "What are we doing here if we don't value communication" ]
                , h4 [] [ text "Lets define (and expand) what 'Communication' means" ]
                ]
        )
    , newSlide "Agile is Communication"
        20
        (\_ ->
            div []
                [ p [] [ text "Team <------> Client" ]
                , p [] [ text "Team <------> Team " ]
                , p [] [ text "Code <--------> Users" ]
                ]
        )
    , newSlide "Design Patterns are Communication"
        30
        (\_ ->
            div []
                [ p [] [ text "\"This class is a Presenter\"" ]
                , p [] [ text "\"You need a guard clause here\"" ]
                ]
        )
    , newSlide "Programming Languages are a form of Communication"
        30
        (\_ ->
            div []
                [ p [] [ text "The language we write it effects our ability to express ourselves through code" ]
                ]
        )
    , newSlide "Society is built on Communication"
        20
        (\_ -> h2 [] [ text "\x1F644" ])
    , newSlide "Overview"
        60
        (\_ ->
            div []
                [ h2 [] [ text "Giving and Receiving Feedback" ]
                , h2 [] [ text "Verbal vs non verbal Communication" ]
                , h2 [] [ text "Process as Communication" ]
                ]
        )
    ]
