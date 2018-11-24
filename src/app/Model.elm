module Model exposing
    ( Model
    , initial
    , modelConfig
    , modelNav
    )

import Config.Model exposing (Config)
import Monocle.Lens exposing (Lens)
import Route.Model exposing (Navigation)


type alias Model =
    { nav : Navigation
    , config : Config
    , dieFace : Int
    }


initial : Navigation -> Config -> Model
initial nav config =
    { nav = nav
    , config = config
    , dieFace = 5
    }


modelConfig : Lens Model Config
modelConfig =
    Lens .config (\b a -> { a | config = b })


modelNav : Lens Model Navigation
modelNav =
    Lens .nav (\b a -> { a | nav = b })
