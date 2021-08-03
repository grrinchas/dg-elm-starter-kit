module Model exposing
    ( Value
    , initial
    , lensConfig
    )

import Config
import Monocle.Lens as Lens



-- MODELS


type alias Value =
    { config : Config.Value
    }



-- CREATING


initial : Config.Value -> Value
initial config =
    { config = config
    }



-- LENSES


lensConfig : Lens.Lens Value Config.Value
lensConfig =
    Lens.Lens .config (\b a -> { a | config = b })
