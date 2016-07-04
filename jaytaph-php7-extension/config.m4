PHP_ARG_ENABLE(domcode, whether to enable domcode support,
    [  --with-domcode                Enable domcode support]
)
PHP_ARG_WITH(domcode-cheat, for cheating purposes,
    [  --with-domcode-cheat=NAME     Always return this name in a raffle ]
)

if test "$PHP_DOMCODE" != "no"; then
    PHP_NEW_EXTENSION(domcode, domcode.c , $ext_shared)
fi

if test "$PHP_DOMCODE_CHEAT" != "no"; then
    AC_DEFINE_UNQUOTED(DOMCODE_CHEAT_NAME, "$PHP_DOMCODE_CHEAT", [ This is definitely not the cheat name ])
fi

