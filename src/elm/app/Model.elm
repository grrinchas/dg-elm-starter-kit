module Model exposing
    ( Model
    , initial
    , lensModelConfig
    )

import Config
import Monocle.Lens exposing (Lens)



-- MODELS


type alias Model =
    { config : Config.Config
    }



-- CREATING


initial : Config.Config -> Model
initial config =
    { config = config
    }



-- LENSES


lensModelConfig : Lens Model Config.Config
lensModelConfig =
    Lens .config (\b a -> { a | config = b })
