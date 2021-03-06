module Slides.Intro exposing (intro, introSlides)

import Html exposing (..)
import Html.Attributes exposing (href)
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
        , h5 [] [ a [ href "http://communication-workshop.surge.sh/" ] [ text "http://communication-workshop.surge.sh/" ] ]
        , h5 [] [ em [] [ text "Use the ⬅️ and ➡️ arrow keys to navigate between slides" ] ]
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
                , p [] [ text "Teacher" ]
                , p [] [ text "Consultant" ]
                , p [] [ text "Rails Developer" ]
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
                , p [] [ text "On-Site Training" ]
                , p [] [ text "Remote Mentoring" ]
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
    , newSlide "My Goals" 30 (\_ -> span [] [])
    , newSlide "Show of Hands" 45 (\_ -> span [] [])
    , newSlide "Why Communication Matters"
        30
        (\_ ->
            div []
                [ h4 [] [ text "What are we doing here if we don't value communication" ]
                , h4 [] [ text "Let's define (and expand) what 'Communication' means" ]
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
                [ p [] [ text "The language we write affects our ability to express ourselves through code" ]
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
