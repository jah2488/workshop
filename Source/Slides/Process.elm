module Slides.Process exposing (processSlides)

import Html exposing (..)
import Html.Attributes exposing (href)
import Common exposing (..)


empty : State -> Html Msg
empty =
    (\_ -> span [] [])


processSlides : List Slide
processSlides =
    [ newSlide "Process As Communication" 60 empty
    , newSlide "What we don't write down says a lot about our team and how its run." 60 empty
      -- Most teams I talk to have __too little__ process, but I know thats not true of everyone so hopefully this is still relevant. Let me know
    , newSlide "Greyhounds and Cornfields" 30 empty
    , newSlide "Greyhounds"
        30
        (\_ ->
            div []
                [ h2 [] [ text "The Bus Factor" ]
                , h4 [] [ text "Someone will get sick or go on vacation or quit... eventually" ]
                ]
        )
    , newSlide "Cornfields"
        30
        (\_ ->
            div []
                [ h2 [] [ text "Knowledge Silos" ]
                , h4 [] [ text "A burden, a single point of failure, and bottleneck" ]
                ]
        )
      -- Oh theres Naghmeh she handles all deploys
      -- There is Jess she does all the redux stuff, idk how that works
      -- Oh Justin he handles getting all team members up to speed after they're added
      -- Oh Cecy? She is in charge of the old system and she is the only one that was here when it was built
    , newSlide "The Checklist Manifesto"
        45
        (\_ ->
            div []
                [ h4 [] [ text "Any sufficiently complex process could benefit from having a checklist." ]
                , h4 [] [ text "Perfect for tasks that cannot be entirely (or partially) automated." ]
                , h4 [] [ text "Helps to cut down on errors" ]
                ]
        )
    , newSlide "\"Houston, we have a problem.\"" 15 empty
      -- So cutting down on errors is great, but it doesn't get rid of errors, nothing really does that
    , newSlide "Learning from NASA"
        50
        (\_ ->
            div []
                [ p []
                    [ text "\"Don’t just fix the mistakes — fix whatever permitted the mistake in the first place.\"" ]
                , p
                    []
                    [ text "\"Importantly, the group avoids blaming people for errors.\"" ]
                , a
                    [ href "https://www.fastcompany.com/28121/they-write-right-stuff" ]
                    [ text "They Write The Right Stuff" ]
                ]
        )
    , newSlide "Procedure Can Become Your Scapegoat"
        30
        (\_ ->
            div []
                [ h4 [] [ text "How do we ensure this doesn't happen again" ]
                , h4 [] [ text "No squabbles over code style in pull requests" ]
                ]
        )
      -- , newSlide "Don't blame the person after a failure" 90 empty
      -- , newSlide "Ask how THE PROCESS allowed for that failure to occur" 90 empty
    , newSlide "Team procedures should be enforced by the whole team"
        50
        (\_ ->
            div []
                [ h4 [] [ text "Don't be the process police" ]
                , h4 [] [ text "Practice collective ownership" ]
                ]
        )
    , newSlide "But what about Agile?"
        45
        (\_ ->
            div []
                [ h4 [] [ text "You can be Agile while having a process" ]
                , h4 [] [ text "The process should never be set in stone" ]
                , h4 [] [ text "Part of your process should be the way to update it" ]
                , h4 [] [ text "Reevaluate past decisions on a regular basis" ]
                , h4 [] [ text "Always record reasonings behind decisions" ]
                ]
        )
    , newSlide "Shape your process before it's painful"
        60
        (\_ ->
            div []
                [ h4 [] [ text "Managing a team of junior developers" ]
                , h4 [] [ text "Becoming a distributed team" ]
                , h4 [] [ text "Becoming a very large team" ]
                ]
        )
    , newSlide "Empower team members by giving them the tools and knowledge" 30 empty
    , newSlide "HANDS ON TIME"
        800
        (\_ ->
            div []
                [ h3 [] [ text "Process Outlining and Checklist" ]
                , p [] [ text "Write down all the steps needed to accomplish task X at your job" ]
                , p [] [ text "Swap with the person next to you and see if you could follow the checklist" ]
                ]
        )
    , newSlide "Communication As Process Takeaways"
        90
        (\_ ->
            div []
                [ h4 [] [ text "What you write communicates into the future" ]
                , h4 [] [ text "Shift blame from the person to the process" ]
                , h4 [] [ text "Keep your process fluid and up to date" ]
                , h4 [] [ text "Practice collective ownership" ]
                , h4 [] [ text "Empower your team to do their job" ]
                ]
        )
    ]
