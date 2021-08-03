module Update exposing (update)

import Cmd
import Command
import Messages
import Model


update : Messages.Value -> Model.Value -> ( Model.Value, Cmd.Value )
update message model =
    case message of
        Messages.NoOperation ->
            model
                |> Command.withoutCmd
