PROJECT = cowboy_post
DEPS = cowboy recon
dep_cowboy = git https://github.com/ninenines/cowboy master
dep_recon = git https://github.com/ferd/recon.git master

include erlang.mk
