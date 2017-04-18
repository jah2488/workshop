module Common exposing (..)

import Html exposing (Html)


type Msg
    = NoOp
    | KeyPressed Int
    | GoTo Slide
    | Next
    | Prev


type Dir
    = Forward
    | Backward


type Position
    = Open
    | Closed


flipDir : Dir -> Dir
flipDir dir =
    case dir of
        Forward ->
            Backward

        Backward ->
            Forward


flipPos : Position -> Position
flipPos position =
    case position of
        Open ->
            Closed

        Closed ->
            Open


type alias Model =
    { previousSlides : List Slide
    , currentSlide : Slide
    , nextSlides : List Slide
    , drawer : Position
    }


type State
    = State Model


type alias Slide =
    { title : String
    , content : State -> Html Msg
    }
