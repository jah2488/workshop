module Main exposing (..)

import Common exposing (..)
import Html exposing (Html, div, h1, h2, h3, h4, hr, node, section, span, text)
import Html.Attributes exposing (class, classList, href, rel, style)
import Html.Events exposing (onClick)
import Keyboard
import List.Extra exposing (uniqueBy)
import Slides.Intro exposing (..)
import Slides.Feedback exposing (..)
import Slides.Limits exposing (..)
import Slides.Process exposing (..)
import Styles exposing (..)
import Time exposing (Time, second)


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions =
            \_ ->
                Sub.batch
                    [ Keyboard.ups KeyPressed
                    , Keyboard.downs KeyHeld
                    , Time.every second Tick
                    ]
        , init = init
        }


init : ( Model, Cmd Msg )
init =
    { previousSlides = []
    , currentSlide = intro
    , shiftHeld = False
    , duration = 0
    , nextSlides =
        -- [ intro ]
        introSlides
            ++ feedbackSlides
            ++ limitsSlides
            ++ processSlides
            ++ [ newSlide "Wrap Up"
                    45
                    (\_ ->
                        div []
                            [ h4 [] [ text "Listen to your team" ]
                            , h4 [] [ text "Be honest, sincere, and empathetic" ]
                            , h4 [] [ text "Assume less and praise more" ]
                            , h4 [] [ text "Write things down" ]
                            , h4 [] [ text "Don't blame the person, blame the (lack of) process" ]
                            ]
                    )
               , newSlide "Goodbye" 300 (\_ -> div [] [ h3 [] [ text "Enjoy the rest of the conference" ], h4 [] [ text "justin@lunarcollective.co" ] ])
               ]
    , drawer = Closed
    }
        ! []


changeSlide : Model -> Dir -> Model
changeSlide model direction =
    let
        previous =
            model.previousSlides

        current =
            model.currentSlide

        next =
            model.nextSlides

        addTo =
            (\xs -> uniqSlides model (current :: xs))

        rest =
            (\xs -> List.tail xs |> Maybe.withDefault [])

        first =
            (\xs -> List.head xs |> Maybe.withDefault current)
    in
        case direction of
            Forward ->
                let
                    newCurrent =
                        first next

                    newNext =
                        rest next

                    newPrevious =
                        if newNext == [] then
                            addTo previous
                        else
                            addTo previous
                in
                    { model
                        | previousSlides = newPrevious
                        , currentSlide = { newCurrent | duration = 0 }
                        , nextSlides = newNext
                    }

            Backward ->
                let
                    newPrevious =
                        rest previous

                    newCurrent =
                        first previous

                    newNext =
                        if newPrevious == [] then
                            addTo next
                        else
                            addTo next
                in
                    { model
                        | previousSlides = newPrevious
                        , currentSlide = { newCurrent | duration = 0 }
                        , nextSlides = newNext
                    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Tick time ->
            let
                currentSlide =
                    model.currentSlide
            in
                { model
                    | duration = model.duration + 1
                    , currentSlide = { currentSlide | duration = currentSlide.duration + 1 }
                }
                    ! []

        KeyHeld int ->
            let
                key =
                    toKey int
            in
                if key == LeftShift then
                    { model | shiftHeld = True } ! []
                else
                    { model | shiftHeld = False } ! []

        KeyPressed int ->
            let
                key =
                    toKey int
            in
                case key of
                    SpaceBar ->
                        { model | drawer = flipPos model.drawer } ! []

                    RightArrow ->
                        changeSlide model Forward ! []

                    LeftArrow ->
                        changeSlide model Backward ! []

                    _ ->
                        model ! []

        Next ->
            changeSlide model Forward ! []

        Prev ->
            changeSlide model Backward ! []

        GoTo targetSlide ->
            let
                all =
                    allSlides model

                { previous, current, next } =
                    List.foldl
                        (\slide output ->
                            if sameSlide targetSlide slide then
                                { output | current = Just slide }
                            else
                                case output.current of
                                    Just _ ->
                                        { output | next = slide :: output.next }

                                    Nothing ->
                                        { output | previous = slide :: output.previous }
                        )
                        { previous = [], current = Nothing, next = [] }
                        all
            in
                { model
                    | previousSlides = previous
                    , currentSlide = Maybe.withDefault model.currentSlide current
                    , nextSlides = next
                }
                    ! []


toTime : Int -> String
toTime n =
    let
        minutes =
            n
                // 60

        minutesStr =
            toString minutes

        seconds =
            rem n 60

        secondsStr =
            (if seconds < 10 then
                ("0" ++ (toString seconds))
             else
                toString seconds
            )
    in
        if minutes > 0 then
            minutesStr ++ ":" ++ secondsStr
        else
            secondsStr


view : Model -> Html Msg
view model =
    section [ style slideShowStyles ]
        [ node "link" [ href "https://fonts.googleapis.com/css?family=Cabin|Poppins", rel "stylesheet" ] []
        , globalStyleTag
        , span
            [ style
                [ ( "position", "fixed" )
                , ( "top", "0" )
                , ( "left", "0" )
                , ( "font-size", "5em" )
                , ( "color", "rgba(200, 200, 200, 0.2)" )
                , ( "margin-left", "3rem" )
                , ( "transition", "all 0.2s ease" )
                , ( "opacity"
                  , if model.drawer == Open then
                        "1"
                    else
                        "0"
                  )
                ]
            ]
            [ text <| toTime model.duration ]
        , section [ style slideStyles ]
            [ h1 [] [ text model.currentSlide.title ]
            , model.currentSlide.content (State model)
            , span
                [ class "over-time"
                , style
                    [ ( "opacity"
                      , if (model.currentSlide.targetDuration <= model.currentSlide.duration) then
                            "1"
                        else
                            "0"
                      )
                    ]
                ]
                []
            ]
        , drawerView model
        ]


uniqSlides : Model -> List Slide -> List Slide
uniqSlides model slides =
    let
        filter =
            (\slide ->
                ( slide.title, toString <| slide.content (State model) )
            )
    in
        uniqueBy filter slides


allSlides : Model -> List Slide
allSlides model =
    uniqSlides model model.previousSlides ++ [ model.currentSlide ] ++ model.nextSlides


drawerView : Model -> Html Msg
drawerView model =
    section []
        [ div
            [ style <| drawerStyles model.drawer ]
            [ navLink Prev "left" "⬅️"
            , slideLinks model.currentSlide model
            , navLink Next "right" "➡️"
            ]
        ]


navLink : Msg -> String -> String -> Html Msg
navLink msg textAlign icon =
    span [ onClick msg, class "nav", style [ ( "flex", "1 0 auto" ), ( "text-align", textAlign ) ] ] [ text icon ]


slideLinks : Slide -> Model -> Html Msg
slideLinks currentSlide model =
    let
        toDrop =
            ((List.length model.previousSlides) - 5)

        toTake =
            ((List.length model.previousSlides) + 5)

        all =
            (model.previousSlides ++ [ currentSlide ] ++ model.nextSlides)
    in
        span [] <|
            (List.indexedMap
                (\idx slide ->
                    if idx > toDrop && idx < toTake then
                        span
                            [ -- [ onClick (GoTo slide)
                              classList [ ( "nav", True ), ( "current", sameSlide currentSlide slide ) ]
                            ]
                            [ text <| toString (idx + 1) ]
                    else
                        text ""
                )
                all
            )
                ++ [ span [ style [ ( "opacity", "0.2" ) ] ] [ text <| "  /  " ++ (toString <| List.length all) ] ]
                ++ [ span [ style [ ( "opacity", "0.2" ) ] ] [ text <| "  (target time:  " ++ (toString <| (List.foldl (\slide acc -> acc + slide.targetDuration) 0 all) // 60) ++ "mins )" ] ]
