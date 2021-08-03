module Cmd exposing
    ( Value
    , example
    , toCommands
    )

import Command
import Messages



-- MODELS


type alias Value =
    Command.Value Custom


type Custom
    = Example



-- CREATING


example : Value
example =
    Command.custom Example



-- TRANSFORMATIONS


toCommands : Custom -> Cmd Messages.Value
toCommands value =
    case value of
        Example ->
            Cmd.none
