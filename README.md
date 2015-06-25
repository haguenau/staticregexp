staticregexp
============

This is an Erlang parse transform to allow compile-time compilation of regular
expressions. `staticregexp:compile(RE)`, where `RE` is a string literal,
computes the same compiled regexp as `re:compile(RE)`, but does so at
compile-time.

To use staticregexp, either add this directive to your source file:

```erlang
-compile({parse_transform, staticregexp}).
```

or, to have every Erlang source file filtered, simply add `{parse_transform, staticregexp}`
to your compiler options (`erl_opts`, when using rebar).

Note: this is really a special case of the functionality provided by `parse_trans`'
`ct_expand`. It might be useful as an example of a simple parse transform.