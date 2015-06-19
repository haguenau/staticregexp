-module(staticregexp).
-export([parse_transform/2]).

-record(state, {}).

parse_transform(Forms, Options) ->
  parse_trans:transform(fun do_transform/4, #state{}, Forms, Options).

do_transform(_Type, Form, _Context, State) -> {Form, false, State}.
