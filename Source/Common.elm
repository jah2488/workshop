module Common exposing (..)

import Html exposing (Html)
import Time exposing (Time)


type Msg
    = NoOp
    | Tick Time
    | KeyPressed Int
    | KeyHeld Int
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
    , shiftHeld : Bool
    , duration : Int
    }


type State
    = State Model


type alias Slide =
    { title : String
    , content : State -> Html Msg
    , targetDuration : Int
    , duration : Int
    }


newSlide : String -> (State -> Html Msg) -> Int -> Slide
newSlide title content target =
    { title = title
    , content = content
    , targetDuration = target
    , duration = 0
    }
