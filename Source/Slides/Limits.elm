module Slides.Limits exposing (limitsSlides)

import Html exposing (..)
import Html.Attributes exposing (href)
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
                , p [] [ text "By The System(s) We Use" ]
                ]
        )
    , newSlide "Perspective" 20 empty
    , newSlide "Our background colors the way we see" 45 (\_ -> h5 [] [ text "Literally" ])
    , newSlide "Wait what?"
        90
        (\_ ->
            div []
                [ h3 [] [ text "Your ability to differentiate between colors is partly due to your upbringing" ]
                , h5 [] [ a [ href "https://6thfloor.blogs.nytimes.com/2012/09/04/its-not-easy-seeing-green/" ] [ text "The Himba of Namibia" ] ]
                , h5 [] [ a [ href "http://www.apa.org/monitor/feb05/hues.aspx" ] [ text "Color is a cultural construct" ] ]
                ]
        )
    , newSlide "Assumptions of commonality can lead to miscommunication" 30 empty
    , newSlide "Different backgrounds and perspectives are great!" 30 empty
    , newSlide "Knowledge" 20 empty
    , newSlide "Our knowledge can impede our communication" 30 empty
    , newSlide "The Monad Problem" 60 empty
    , newSlide "The Monad Problem?"
        90
        (\_ ->
            div []
                [ h5 []
                    [ em [] [ text "“[monads are] something that once developers really manage to understand, instantly lose the ability to explain to anybody else”." ]
                    , text "  -- Douglas Crockford"
                    ]
                ]
        )
    , newSlide "The Senior Developer Dillema" 180 empty
    , newSlide "Emotional State" 30 empty
    , newSlide "Our ability to express is tied to our emotional state" 50 empty
    , newSlide "Be mindful of ourselves so we can better convey that to our team" 45 empty
    , newSlide "System(s)" 30 empty
    , newSlide "Non Verbal Communication"
        30
        (\_ ->
            div []
                [ h3 [] [ text "In some teams the vast majority of our communication is non verbal" ]
                , p [] [ text "Slack" ]
                , p [] [ text "Email" ]
                , p [] [ text "Github" ]
                , p [] [ text "Trello / Jira / Carrier Pigeon" ]
                ]
        )
    , newSlide "Text based communication has a negativity bias"
        30
        (\_ ->
            div []
                [ h3 [] [ text "Culture of Code Reviews" ]
                , h5 [] [ a [ href "https://www.youtube.com/watch?v=PJjmw9TRB7s" ] [ text "A very good talk by Derek Prior" ] ]
                , h5 [] [ a [ href "https://en.wikipedia.org/wiki/Emotions_in_virtual_communication#Interpretations_of_emotion" ] [ text "Wikipedia: Emails" ] ]
                ]
        )
    , newSlide "So, how do we do better?" 30 empty
    , newSlide "Convey expectations cleary" 30 empty
    , newSlide "Explain the context and reasoning behind decisions or statements" 45 empty
    , newSlide "Be prepared to take conversations offline" 30 empty
    , newSlide "When Being Critical"
        60
        (\_ ->
            div []
                [ h3 [] [ text "Identify Strengths" ]
                , h3 [] [ text "Suggest Solutions" ]
                , h3 [] [ text "Be overly (or explicitly) emotive 👍" ]
                ]
        )
    , newSlide "🙅 Establish Rituals 🙅"
        60
        (\_ ->
            div []
                [ h4 [] [ text "Routines reducing anxiety by reducing uncertainty" ]
                , h4 [] [ text "Allows you to actively shape your team's culture" ]
                ]
        )
    , newSlide "HANDS ON TIME"
        800
        (\_ ->
            div []
                [ h4 [] [ text "Sight Unseen Pair Programming" ]
                , h5 [] [ text "Using", em [] [ text " only " ], text "our words" ]
                ]
        )
    , newSlide "Communication Limits Takeaways"
        90
        (\_ ->
            div []
                [ p [] [ text "Don't assume a shared background or perspective" ]
                , p [] [ text "Practice explaining technical topics without jargon" ]
                , p [] [ text "Know when to take a minute if your emotions are getting the best of you" ]
                , p [] [ text "Combat the negativity bias of virtual communication" ]
                , p [] [ small [] [ text "Be Emotive 😀" ] ]
                , p [] [ small [] [ text "Establish Rituals" ] ]
                , p [] [ small [] [ text "Explaining context, reasoning, and expectations explicitely" ] ]
                ]
        )
    ]
