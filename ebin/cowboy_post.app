{application, cowboy_post, [
	{description, ""},
	{vsn, "0.1.0"},
	{id, "v4-dirty"},
	{modules, ['cowboy_post_app','cowboy_post_sup','echo_handler','rpn_handler']},
	{registered, []},
	{applications, [
		kernel,
		stdlib,
        cowboy,
        recon
	]},
	{mod, {cowboy_post_app, []}},
	{env, []}
]}.
