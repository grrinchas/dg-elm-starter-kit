module Command exposing
    ( Value
    , andThen
    , batch
    , custom
    , list
    , map
    , none
    , withCmd
    , withoutCmd
    )

{- Generic type which abstracts same functions which can be used on custom commands. So for example,
   if you wish to make a HTTP request to get users you can create a type which represents this side effect:

       type Effects = GetUser

       type MyCommand = Command.Value Effects

   And inside update function you would change `Cmd msg` into `MyCommand`.

   Using this method you can isolate all side effects into one place, also it makes your Update function Testable.
-}


type Value a
    = None
    | Custom a
    | Batch (List (Value a))


none : Value a
none =
    None


batch : List (Value a) -> Value a
batch =
    Batch


custom : a -> Value a
custom =
    Custom



-- MAPPERS


map : (a -> b) -> Value a -> Value b
map mapper val =
    case val of
        None ->
            None

        Custom a ->
            Custom (mapper a)

        Batch values ->
            Batch (List.map (map mapper) values)


withoutCmd : model -> ( model, Value a )
withoutCmd model =
    ( model, none )


withCmd : List (Value a) -> model -> ( model, Value a )
withCmd cmds model =
    ( model, batch cmds )


andThen : (model -> ( model, Value a )) -> ( model, Value a ) -> ( model, Value a )
andThen mapper ( model, cmd ) =
    mapper model
        |> (\( newModel, newCmd ) ->
                ( newModel, batch [ cmd, newCmd ] )
           )


list : Value a -> List a
list value =
    case value of
        None ->
            []

        Custom a ->
            [ a ]

        Batch values ->
            List.concat (List.map list values)
