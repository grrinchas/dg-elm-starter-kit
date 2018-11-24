module Lib.Extra exposing (withCommands, noCommands)

import Monocle.Lens exposing (Lens, compose)



withCommands : List (Cmd msg) -> model -> ( model, Cmd msg )
withCommands list model =
    ( model, Cmd.batch list )


noCommands: model -> ( model, Cmd msg )
noCommands =
    withCommands []
