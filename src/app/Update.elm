module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (Model)
import Route.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        OnNop ->
            ( model, Cmd.none )

        OnRoute msg ->
            Route.Update.update msg model

