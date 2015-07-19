{application, cowboy_post, [
	{description, ""},
	{vsn, "0.1.0"},
	{id, "v1-2-g968f52d-dirty"},
	{modules, ['cowboy_post_app','cowboy_post_sup','echo_handler','rpn_handler']},
	{registered, []},
	{applications, [
		kernel,
		stdlib,
        cowboy
	]},
	{mod, {cowboy_post_app, []}},
	{env, []}
]}.
