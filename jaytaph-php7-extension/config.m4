PHP_ARG_ENABLE(domcode, whether to enable domcode support,
    [  --with-domcode                Enable domcode support]
)

if test "$PHP_DOMCODE" != "no"; then
    PHP_NEW_EXTENSION(domcode, domcode.c , $ext_shared)
fi
