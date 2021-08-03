module View exposing (view)

import Element
import Element.Font
import Html
import Messages
import Model


options : List Element.Option
options =
    [ Element.focusStyle
        { borderColor = Nothing
        , backgroundColor = Nothing
        , shadow = Nothing
        }
    ]


attributes : Model.Value -> List (Element.Attribute Messages.Value)
attributes _ =
    [ Element.width Element.fill
    , Element.height Element.fill
    , Element.Font.family
        [ Element.Font.typeface "Roboto"
        , Element.Font.sansSerif
        ]
    ]


mainView : Model.Value -> Element.Element Messages.Value
mainView _ =
    Element.text "Welcome to DG Elm Starter Kit"


view : Model.Value -> Html.Html Messages.Value
view model =
    Element.layoutWith { options = options } (attributes model) (mainView model)
