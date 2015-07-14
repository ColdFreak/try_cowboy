{application, cowboy_post, [
	{description, ""},
	{vsn, "0.1.0"},
	{id, "v1-1-g607135c"},
	{modules, ['cowboy_post_app','cowboy_post_sup','echo_handler']},
	{registered, []},
	{applications, [
		kernel,
		stdlib,
        cowboy
	]},
	{mod, {cowboy_post_app, []}},
	{env, []}
]}.
