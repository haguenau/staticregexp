-module(staticregexp).
-export([parse_transform/2]).

parse_transform(Forms, _Options) ->
  parse_trans:plain_transform(fun apply_transform/1, Forms).

apply_transform(
    {call, Line,
      {remote, _, {atom, _, staticregexp}, {atom, _, compile}},
      [{string, _, String}]}) ->
      Compiled = re:compile(String),
      case Compiled of
        {ok, Regexp} ->
          erl_parse:abstract(Regexp, Line);
        _ ->
          io:format(standard_error, "staticregexp: Call to re:compile failed: ~p~n", [Compiled]),
          invalid
      end;

apply_transform({call, _, {remote, _, {atom, _, staticregexp}, {atom, _, compile}}, Params}) ->
  NormalisedParams = lists:map(fun erl_parse:normalise/1, Params),
  io:format(standard_error, "staticregexp: Bad parameters to staticregexp:compile: ~p~n",
    [NormalisedParams]),
  invalid;

apply_transform(_Form) ->
  continue.
