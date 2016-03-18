/*
   +----------------------------------------------------------------------+
   | Domcode raffler extension. Only compatible with PHP7 not PHP5.       |
   |                                                                      |
   | MIT licenced                                                         |
   +----------------------------------------------------------------------+
   | Author: Joshua Thijssen <jthijssen@noxlogic.nl>                      |
   +----------------------------------------------------------------------+
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// Main stuff we need, or many we don't
#include "php.h"
#include "php_main.h"
#include "php_globals.h"
#include "zend_objects.h"
#include "zend_exceptions.h"
#include "ext/standard/info.h"
#include "php_domcode.h"


// Internal domcode object data holding our internal array and the actual zend object being the DomData object
typedef struct _php_domcode_obj {
    zval            users;             // An internal array of all registered users
    zend_object     zo;                // The actual zend object
} php_domcode_obj;

// The class entry pointers. We don't really use this, but it's good to have a reference to the actual class if you
// really create an extension that does something (useful).
zend_class_entry *php_domcode_sc_entry;

// The object handlers for DomData. Defines how to (de)allocate, clone, magic setters and more. By default we will
// copy the standard PHP object handlers, but you can override this easily with custom handlers (for handling)
static zend_object_handlers domcode_object_handlers;

// Some defines that allows us to fetch the internal php_domcode_obj structure. Still think PHP5 was easier :(
#define fetch_domcode_obj_from(z) (php_domcode_obj *)((char*)z- XtOffsetOf(php_domcode_obj, zo))
#define fetch_domcode_obj(z) fetch_domcode_obj_from(Z_OBJ_P(z))


/* proto domcode::__construct()
 * Constructs a new domcode object. */
PHP_METHOD(domcode, __construct) {
    // Make sure we don't get any parameters
    if (zend_parse_parameters_none() == FAILURE) {
        return;
    }

    // Nothing to do here, but you can do whatever you want...
}



/* proto string domcode::addName(string)
 * Adds a new user to the domcode raffler */
PHP_METHOD(domcode, addName) {
    php_domcode_obj *intern;
    zend_string *user;

    // Make sure we are called with a single string as argument
    if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "S", &user) == FAILURE) {
            RETURN_FALSE
    }

    // Fetch internal structure
    intern = fetch_domcode_obj(getThis());

    // Add string to internal hash
    add_next_index_str(&intern->users, user);
}

/* proto string domcode::raffle()
 * Returns a random name from the list */
PHP_METHOD(domcode, raffle) {
    php_domcode_obj *intern;
    zval *winner;

    // No need to call with arguments
    if (zend_parse_parameters_none() == FAILURE) {
        RETURN_FALSE
    }

#ifdef DOMCODE_CHEAT_NAME
    // No nasty business happing here.. move along now...
    RETURN_STRING(DOMCODE_CHEAT_NAME);
#endif

    // Fetch internal structure
    intern = fetch_domcode_obj(getThis());

    // Find a random index from the internal array
    int elementCount = zend_hash_num_elements(Z_ARRVAL_P(&intern->users));
    do {
        winner = zend_hash_index_find(Z_ARRVAL_P(&intern->users), php_rand() % elementCount);
        // Repeat in case we have struck an index that did not exist (for instance, when there are gaps in the array)
    } while (! winner);

    // And return the winner
    RETURN_ZVAL(winner, 0, 0);
}


// Function that is called when object is freed by PHP
static void domcode_object_free(void *object TSRMLS_DC) {
    php_domcode_obj *intern = (php_domcode_obj *)object;

    // Free internal stuff
    zval_dtor(&intern->users);

    // destruct object
    zend_object_std_dtor(&intern->zo TSRMLS_CC);

    efree(intern);
}

// Function that is called when the object is created by PHP
static zend_object *domcode_object_new(zend_class_entry *ce) {
    php_domcode_obj *intern;

    // Allocate room for our internal structure and our zend object, and clear memory
    intern = emalloc(sizeof(php_domcode_obj) + zend_object_properties_size(ce));
    memset(intern, 0, sizeof(php_domcode_obj) + zend_object_properties_size(ce));

    // Allocate room for initial hash
    array_init(&intern->users);

    // Set default properties and stuff
    zend_object_std_init(&intern->zo, ce);
    object_properties_init(&intern->zo, ce);

    // Make sure this object uses our handlers
    intern->zo.handlers = (zend_object_handlers *) &domcode_object_handlers;

    return &intern->zo;
}

// A list of all our classes and methods and stuff (not constants and properties though)
static zend_function_entry domcode_funcs[] = {
    PHP_ME(domcode, __construct,     NULL, ZEND_ACC_PUBLIC | ZEND_ACC_CTOR)
    PHP_ME(domcode, raffle,          NULL, ZEND_ACC_PUBLIC)
    PHP_ME(domcode, addName,         NULL, ZEND_ACC_PUBLIC)
    /* End of functions */
    {NULL, NULL, NULL}
};

// Module init function
PHP_MINIT_FUNCTION(domcode)
{
    zend_class_entry ce;

    // Copy the standard object handlers. If we want to change some handling in domcode, we use domcode_object_handlers
    memcpy(&domcode_object_handlers, zend_get_std_object_handlers(), sizeof(zend_object_handlers));


    // Initialize DomCode CLASS, (not an instance)
    INIT_CLASS_ENTRY(ce, "DomCode", domcode_funcs);

    // Use a custom method of creating instances (since we need to do custom stuff there)
    ce.create_object = &domcode_object_new;

    // Register this class
    php_domcode_sc_entry = zend_register_internal_class(&ce TSRMLS_CC);

    return SUCCESS;
}

// Small shutdown function
PHP_MSHUTDOWN_FUNCTION(domcode) {
    return SUCCESS;
}

// Used for displaying all kind of cool things when calling phpinfo(). Protip: add some lolcat gifs to here
PHP_MINFO_FUNCTION(domcode)
{
    php_info_print_table_start();
    php_info_print_table_header(2, "DomCode support", "enabled");
    php_info_print_table_row(2, "Version", PHP_DOMCODE_VERSION);
    php_info_print_table_row(2, "Website", PHP_DOMCODE_URL);
    php_info_print_table_row(2, "Author", PHP_DOMCODE_AUTHOR);
    php_info_print_table_end();
}


// Module/extension definition
zend_module_entry domcode_module_entry = {
    STANDARD_MODULE_HEADER,         // Standard boiler plate stuff
    "DomCode",                      // Name of our extension
    domcode_funcs,                  // Functions / methods in this extension
    PHP_MINIT(domcode),             // Function that will initialise the module
    PHP_MSHUTDOWN(domcode),         // Function that will shutdown the module
    NULL,                           // probably not important :)
    NULL,                           // very null
    PHP_MINFO(domcode),             // Function that will display phpinfo() stuff
    PHP_DOMCODE_VERSION,            // extension version
    STANDARD_MODULE_PROPERTIES      // And more standard stuff
};

//#ifdef COMPILE_DL_domcode
ZEND_GET_MODULE(domcode)           // Keep this
//#endif
