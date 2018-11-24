module Config.Model exposing
    ( Config
    , Mode
    , development
    , production
    , modeFromString
    )


type alias Config =
    { mode : Mode
    , fragment: Bool
    }


type Mode
    = Development
    | Production


development: Mode
development = Development


production: Mode
production = Production


modeToString : Mode -> String
modeToString mode =
    case mode of
        Development ->
            "Development"

        Production ->
            "Production"


modeFromString : String -> Maybe Mode
modeFromString string =
    case String.toLower string of
        "development" ->
            Just Development

        "production" ->
            Just Production

        _ ->
            Nothing


