module Main exposing (..)

import Common exposing (..)
import Html exposing (Html, div, hr, node, section, span, text)
import Html.Attributes exposing (class, classList, href, rel, style)
import Html.Events exposing (onClick)
import Keyboard
import Slides.Feedback exposing (feedback)
import Slides.Intro exposing (intro)
import Styles exposing (..)
import Time exposing (Time, second)


type Key
    = SpaceBar
    | RightArrow
    | LeftArrow
    | LeftShift
    | None


toKey : Int -> Key
toKey int =
    case int of
        16 ->
            LeftShift

        32 ->
            SpaceBar

        39 ->
            RightArrow

        37 ->
            LeftArrow

        _ ->
            None


uniq : List a -> List a
uniq xs =
    List.foldr
        (\item xxs ->
            if List.member item xxs then
                xxs
            else
                item :: xxs
        )
        []
        xs


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
        [ feedback
        , { title = "Third Slide", content = (\_ -> text "Words!"), duration = 0, targetDuration = 15 }
        , { title = "Forth Slide", content = (\_ -> text "Go Go go"), duration = 0, targetDuration = 20 }
        , { title = "Final Concolusion"
          , content =
                (\_ ->
                    div []
                        [ text "thankyou"
                        , div [ onClick <| GoTo intro ] []
                        ]
                )
          , duration = 0
          , targetDuration = 40
          }
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
            (\xs ->
                if List.member current xs then
                    xs
                else
                    current :: xs
            )

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
                            if targetSlide == slide then
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
            [ div [] [ text model.currentSlide.title ]
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


allSlides : Model -> List Slide
allSlides model =
    uniq <| model.previousSlides ++ [ model.currentSlide ] ++ model.nextSlides


drawerView : Model -> Html Msg
drawerView model =
    section []
        [ div
            [ style <| drawerStyles model.drawer ]
            [ navLink Prev "left" "⬅️"
            , slideLinks model.currentSlide (allSlides model)
            , navLink Next "right" "➡️"
            ]
        ]


navLink : Msg -> String -> String -> Html Msg
navLink msg textAlign icon =
    span [ onClick msg, class "nav", style [ ( "flex", "1 0 auto" ), ( "text-align", textAlign ) ] ] [ text icon ]


slideLinks : Slide -> List Slide -> Html Msg
slideLinks currentSlide slideList =
    span []
        (List.indexedMap
            (\idx slide ->
                span
                    [ onClick (GoTo slide)
                    , classList [ ( "nav", True ), ( "current", currentSlide == slide ) ]
                    ]
                    [ text <| toString (idx + 1) ]
            )
            slideList
        )
