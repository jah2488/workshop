module Slides.Feedback exposing (feedbackSlides)

import Html exposing (..)
import Html.Attributes exposing (href)
import Common exposing (..)


feedback : Slide
feedback =
    newSlide "Feedback" 10 (\model -> text "hi")


empty : State -> Html Msg
empty =
    (\_ -> span [] [])


feedbackSlides : List Slide
feedbackSlides =
    [ newSlide "Feedback" 10 empty
    , newSlide "First a Warning"
        30
        (\_ ->
            div []
                [ p [] [ text "Giving feedback is hard." ]
                , p [] [ strong [] [ text "Giving good feedback is very hard" ] ]
                , p [] [ text "Receiving feedback (good or bad) can be tough" ]
                , p [] [ text "Always keep that in mind, regardless of what side of the feedback you find yourself." ]
                ]
        )
    , newSlide "Giving Feedback"
        60
        (\_ ->
            div []
                [ p [] [ text "Giving feedback is part of the job" ]
                , p [] [ text "We improve our job by being better at giving it" ]
                ]
        )
    , newSlide "Be a Good Listener" 30 empty
    , newSlide "Be aware of the context" 30 empty
    , newSlide "Effective Feedback is a dialog" 30 empty
    , newSlide "Be"
        45
        (\_ ->
            div []
                [ h3 [] [ text "Available" ]
                , h3 [] [ text "Empathetic" ]
                , h3 [] [ text "Sincere" ]
                ]
        )
    , newSlide "How To Win Friends And Influence People" 45 empty
    , newSlide "Book Focuses On"
        60
        (\_ ->
            div []
                [ h4 [] [ text "Handling People" ]
                , h4 [] [ text "Making People Like You" ]
                , h4 [] [ text "Winning People To Your Way of Thinking" ]
                , h4 [] [ text "Being an Effective Leader" ]
                ]
        )
    , newSlide "\"Don't Criticize, Condemn, or Complain\"" 30 empty
    , newSlide "\"Give Honest and Sincere Praise\"" 30 empty
    , newSlide "\"Be Genuine\"" 30 empty
    , newSlide "\"Be a Good Listener: Encourage Others To Speak\"" 30 empty
    , newSlide "\"If You Find You Are Wrong, Admit It Quickly And Emphatically\"" 30 empty
    , newSlide "\"Mention Your Own Mistakes Before Making A Criticism\"" 30 empty
    , newSlide "Receiving Questions" 20 empty
    , newSlide "Sasha Laundry's Our Brain's API"
        60
        (\_ ->
            div []
                [ small [] [ a [ href "http://blog.sashalaundy.com/talks/asking-helping/" ] [ text "Seriously. Go watch it" ] ]
                , p [] [ text "Assume Competence" ]
                , p [] [ text "Dont feign surprise (or outrage)" ]
                , p [] [ text "Share the how and the why, along with the what" ]
                , p [] [ text "Don't take control" ]
                , p [] [ text "What your Language" ]
                ]
        )
    , newSlide "HANDS ON TIME" 600 (\_ -> h2 [] [ text "Code Review Rapid Fire" ])
    , newSlide "Feedback Takeaways"
        60
        (\_ ->
            div []
                [ p [] [ text "Be a good listener" ]
                , p [] [ text "Make sure your team knows you're trying and available" ]
                , p [] [ text "Its better to be explicit in our praise than to assume its received" ]
                , p [] [ text "Criticisms are more effective in an open/safe enviornment" ]
                , small [] [ text "Sometimes that means in private" ]
                , p [] [ text "Mind our language" ]
                , p [] [ text "Practice Empathy and Honesty" ]
                ]
        )
    ]
