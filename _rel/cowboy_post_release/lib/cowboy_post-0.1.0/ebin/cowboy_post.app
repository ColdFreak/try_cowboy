{application, cowboy_post, [
	{description, ""},
	{vsn, "0.1.0"},
	{id, "dbcea96-dirty"},
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
