module Main exposing (..)

import Html exposing (Html, span, div, section, hr, text, node)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class, classList, href, rel)
import Keyboard
import Common exposing (..)
import Styles exposing (..)
import Slides.Intro exposing (intro)
import Slides.Feedback exposing (feedback)


type Key
    = SpaceBar
    | RightArrow
    | LeftArrow
    | None


toKey : Int -> Key
toKey int =
    case int of
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
        , subscriptions = \_ -> Keyboard.ups KeyPressed
        , init = init
        }


init : ( Model, Cmd Msg )
init =
    { previousSlides = []
    , currentSlide = intro
    , nextSlides =
        [ feedback
        , { title = "Second Slide", content = (\_ -> text "Words!") }
        , { title = "Third Slide", content = (\_ -> text "Go Go go") }
        , { title = "Concolusion"
          , content =
                (\_ ->
                    div []
                        [ text "thankyou"
                        , div [ onClick <| GoTo intro ] []
                        ]
                )
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
                    { model | previousSlides = newPrevious, currentSlide = newCurrent, nextSlides = newNext }

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
                    { model | previousSlides = newPrevious, currentSlide = newCurrent, nextSlides = newNext }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

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

                    None ->
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


view : Model -> Html Msg
view model =
    section [ style slideShowStyles ]
        [ node "link" [ href "https://fonts.googleapis.com/css?family=Cabin|Poppins", rel "stylesheet" ] []
        , globalStyleTag
        , section [ style slideStyles ]
            [ div [] [ text model.currentSlide.title ]
            , model.currentSlide.content (State model)
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
            [ span [ onClick Prev, class "nav", style [ ( "flex", "1 0 auto" ) ] ] [ text "⬅️" ]
            , span []
                (List.indexedMap
                    (\idx slide ->
                        span
                            [ onClick (GoTo slide)
                            , classList [ ( "nav", True ), ( "current", model.currentSlide == slide ) ]
                            ]
                            [ text <| toString (idx + 1) ]
                    )
                    (allSlides model)
                )
            , span [ onClick Next, class "nav", style [ ( "flex", "1 0 auto" ), ( "text-align", "right" ) ] ]
                [ text "➡️" ]
            ]
        ]
