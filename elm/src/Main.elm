port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)


-- MODEL


type alias Model =
    { fileName : Maybe String
    , softWrap : Bool
    , tabLength : Int
    , encoding : String
    , lineCount : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { fileName = Nothing
      , softWrap = False
      , tabLength = 4
      , encoding = "UTF-8"
      , lineCount = 0
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = TextEditorPaneChanged Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        TextEditorPaneChanged model ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view { fileName, softWrap, tabLength, encoding, lineCount } =
    let
        fileNameText =
            fileName |> Maybe.withDefault "Untitled"

        softWrapText =
            if softWrap then
                "yes"
            else
                "no"
    in
        div [ class "elm-boilerplate" ]
            [ h2 [] [ text fileNameText ]
            , ul []
                [ itemView "Soft Wrap" softWrapText
                , itemView "Tab Length" (toString tabLength)
                , itemView "Encoding" encoding
                , itemView "Line Count" (toString lineCount)
                ]
            ]


itemView : String -> String -> Html msg
itemView label value =
    li []
        [ b [] [ text <| label ++ ": " ++ value ] ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    textEditorPaneChanged TextEditorPaneChanged



-- INCOMING PORTS


port textEditorPaneChanged : (Model -> msg) -> Sub msg



-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
