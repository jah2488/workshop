module Common exposing (..)

import Html exposing (Html, span)
import Time exposing (Time)


type Msg
    = NoOp
    | Tick Time
    | KeyPressed Int
    | KeyHeld Int
    | GoTo Slide
    | Next
    | Prev


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


emptyModel : Model
emptyModel =
    { previousSlides = [], currentSlide = { title = "", content = \state -> span [] [], targetDuration = 0, duration = 0 }, nextSlides = [], drawer = Open, shiftHeld = False, duration = 0 }


type State
    = State Model


type alias Slide =
    { title : String
    , content : State -> Html Msg
    , targetDuration : Int
    , duration : Int
    }


newSlide : String -> Int -> (State -> Html Msg) -> Slide
newSlide title target content =
    { title = title
    , content = content
    , targetDuration = target
    , duration = 0
    }


sameSlide : Slide -> Slide -> Bool
sameSlide slidea slideb =
    slidea.targetDuration
        == slideb.targetDuration
        && slidea.title
        == slideb.title
        && slidea.content (State emptyModel)
        == slideb.content (State emptyModel)
