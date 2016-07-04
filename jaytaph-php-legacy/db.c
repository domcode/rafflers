/*
   +----------------------------------------------------------------------+
   | PHP HTML Embedded Scripting Language Version 3.0                     |
   +----------------------------------------------------------------------+
   | Copyright (c) 1997,1998 PHP Development Team (See Credits file)      |
   +----------------------------------------------------------------------+
   | This program is free software; you can redistribute it and/or modify |
   | it under the terms of one of the following licenses:                 |
   |                                                                      |
   |  A) the GNU General Public License as published by the Free Software |
   |     Foundation; either version 2 of the License, or (at your option) |
   |     any later version.                                               |
   |                                                                      |
   |  B) the PHP License as published by the PHP Development Team and     |
   |     included in the distribution in the file: LICENSE                |
   |                                                                      |
   | This program is distributed in the hope that it will be useful,      |
   | but WITHOUT ANY WARRANTY; without even the implied warranty of       |
   | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        |
   | GNU General Public License for more details.                         |
   |                                                                      |
   | You should have received a copy of both licenses referred to here.   |
   | If you did not, or have any questions about PHP licensing, please    |
   | contact core@php.net.                                                |
   +----------------------------------------------------------------------+
   | Authors: Rasmus Lerdorf <rasmus@lerdorf.on.ca>                       |
   |          Jim Winstead <jimw@php.net>                                 |
   +----------------------------------------------------------------------+
 */

/* $Id: db.c,v 1.70 1998/06/01 04:16:07 shane Exp $ */
#if COMPILE_DL
#include "dl/phpdl.h"
#endif

#include "php.h"
#include "internal_functions.h"
#include "php3_list.h"

#include <stdlib.h>
#include <string.h>
#include <errno.h>
#if HAVE_UNISTD_H
#include <unistd.h>
#endif

#if HAVE_SYS_FILE_H && !HAVE_LOCKF && HAVE_FLOCK
#if WIN32|WINNT
#include "win32/flock.h"
#else
#include <sys/file.h>
#endif
#endif

#if HAVE_FCNTL_H
#include <fcntl.h>
#endif

#if GDBM
#include <gdbm.h>

#define DBM_TYPE GDBM_FILE
#define DBM_MODE_TYPE int
#define DBM_WRITE_MODE GDBM_WRITER
#define DBM_CREATE_MODE GDBM_WRCREAT
#define DBM_NEW_MODE GDBM_NEWDB
#define DBM_DEFAULT_MODE GDBM_READER
#define DBM_OPEN(filename, mode) gdbm_open(filename, 512, mode, 0666, 0)
#define DBM_CLOSE(dbf) gdbm_close(dbf)
#define DBM_STORE(dbf, key, value, mode) gdbm_store(dbf, key, value, mode)
#define DBM_FETCH(dbf, key) gdbm_fetch(dbf, key)
#define DBM_EXISTS(dbf, key) gdbm_exists(dbf, key)
#define DBM_DELETE(dbf, key) gdbm_delete(dbf, key)
#define DBM_FIRSTKEY(dbf) gdbm_firstkey(dbf)
#define DBM_NEXTKEY(dbf, key) gdbm_nextkey(dbf, key)

#define DBM_INSERT GDBM_INSERT
#define DBM_REPLACE GDBM_REPLACE
#endif

#if NDBM && !GDBM
#if BSD2
#define DB_DBM_HSEARCH 1
#include <db.h>
#else
#include <ndbm.h>
#endif

#define DBM_TYPE DBM *
#define DBM_MODE_TYPE int
#define DBM_WRITE_MODE O_RDWR
#define DBM_CREATE_MODE O_RDWR | O_APPEND | O_CREAT
#define DBM_NEW_MODE O_RDWR | O_CREAT | O_TRUNC
#define DBM_DEFAULT_MODE O_RDONLY
#define DBM_OPEN(filename, mode) dbm_open(filename, mode, 0666)
#define DBM_CLOSE(dbf) dbm_close(dbf)
#define DBM_STORE(dbf, key, value, mode) dbm_store(dbf, key, value, mode)
#define DBM_FETCH(dbf, key) dbm_fetch(dbf, key)
#define DBM_EXISTS(dbf, key) _php3_dbm_exists(dbf, key)
#define DBM_DELETE(dbf, key) dbm_delete(dbf, key)
#define DBM_FIRSTKEY(dbf) dbm_firstkey(dbf)
#define DBM_NEXTKEY(dbf, key) dbm_nextkey(dbf)

static int _php3_dbm_exists(DBM *dbf, datum key_datum) {
	datum value_datum;
	int ret;

	value_datum = dbm_fetch(dbf, key_datum);
	if (value_datum.dptr)
		ret = 1;
	else
		ret = 0;
	return ret;
}
#endif

#if !NDBM && !GDBM
#define DBM_TYPE FILE *

#define DBM_MODE_TYPE char *
#define DBM_WRITE_MODE "r+b"
#define DBM_CREATE_MODE "a+b"
#define DBM_NEW_MODE "w+b"
#define DBM_DEFAULT_MODE "r"
#define DBM_OPEN(filename, mode) fopen(filename, mode)
#define DBM_CLOSE(dbf) fclose(dbf)
#define DBM_STORE(dbf, key, value, mode) flatfile_store(dbf, key, value, mode)
#define DBM_FETCH(dbf, key) flatfile_fetch(dbf, key)
#define DBM_EXISTS(dbf, key) flatfile_findkey(dbf, key)
#define DBM_DELETE(dbf, key) flatfile_delete(dbf, key)
#define DBM_FIRSTKEY(dbf) flatfile_firstkey(dbf)
#define DBM_NEXTKEY(dbf, key) flatfile_nextkey(dbf)

#define DBM_INSERT 0
#define DBM_REPLACE 1

typedef struct {
        char *dptr;
        int dsize;
} datum;

int flatfile_store(FILE *dbf, datum key, datum value, int mode);
datum flatfile_fetch(FILE *dbf, datum key);
int flatfile_findkey(FILE *dbf, datum key);
int flatfile_delete(FILE *dbf, datum key);
datum flatfile_firstkey(FILE *dbf);
datum flatfile_nextkey(FILE *dbf);
#endif

#include "functions/db.h"
#include "functions/php3_string.h"

#if THREAD_SAFE
DWORD DbmTls;
static int numthreads=0;

typedef struct dbm_global_struct{
	int le_db;
}dbm_global_struct;

#define DBM_GLOBAL(a) dbm_globals->a

#define DBM_TLS_VARS \
	dbm_global_struct *dbm_globals; \
	dbm_globals=TlsGetValue(DbmTls); 

#else
static int le_db;
#define DBM_GLOBAL(a) a
#define DBM_TLS_VARS
#endif

/*needed for blocking calls in windows*/
void *dbm_mutex;

dbm_info *_php3_finddbm(pval *id,HashTable *list)
{
	list_entry *le;
	dbm_info *info;
	int numitems, i;
	int info_type;
	DBM_TLS_VARS;

	if (id->type == IS_STRING) {
		numitems = hash_num_elements(list);
		for (i=1; i<=numitems; i++) {
			if (hash_index_find(list, i, (void **) &le)==FAILURE) {
				continue;
			}
			if (le->type == DBM_GLOBAL(le_db)) {
				info = (dbm_info *)(le->ptr);
				if (!strcmp(info->filename, id->value.str.val)) {
					return (dbm_info *)(le->ptr);
				}
			}
		}
	}

	/* didn't find it as a database filename, try as a number */
	convert_to_long(id);
	info = php3_list_find(id->value.lval, &info_type);
	if (info_type != DBM_GLOBAL(le_db))
		return NULL;
	return info;
}

static char *php3_get_info_db(void)
{
	static char temp1[128];
	static char temp[256];

	temp1[0]='\0';
	temp[0]='\0';

#ifdef DB_VERSION_STRING /* using sleepycat dbm */
	strcat(temp,DB_VERSION_STRING);
#endif

#if GDBM
	sprintf(temp1,"%s",gdbm_version);
	strcat(temp,temp1);
#endif

#if NDBM && !GDBM
	strcat(temp,"ndbm support enabled");
#endif	

#if !GDBM && !NDBM
	strcat(temp,"flat file support enabled");
#endif	

#if NFS_HACK
	strcat(temp,"NFS hack in effect");
#endif

	if (!*temp)
		strcat(temp,"No database support");

	return temp;
}


void php3_info_db(void)
{
	PUTS(php3_get_info_db());
}

void php3_dblist(INTERNAL_FUNCTION_PARAMETERS)
{
	char *str = php3_get_info_db();
	RETURN_STRING(str,1);
}


void php3_dbmopen(INTERNAL_FUNCTION_PARAMETERS) {
	pval *filename, *mode;
	dbm_info *info;
	int ret;
	DBM_TLS_VARS;

	if (ARG_COUNT(ht)!=2 || getParameters(ht,2,&filename,&mode)==FAILURE) {
		WRONG_PARAM_COUNT;
	}

	convert_to_string(filename);
	convert_to_string(mode);
	
	info = _php3_dbmopen(filename->value.str.val, mode->value.str.val);
	if (info) {
		ret = php3_list_insert(info, DBM_GLOBAL(le_db));
		RETURN_LONG(ret);
	} else {
		RETURN_FALSE;
	}
}

dbm_info *_php3_dbmopen(char *filename, char *mode) {
	dbm_info *info;
	int ret, lock=0;
	char *lockfn = NULL;
	int lockfd = 0;

#if NFS_HACK
	int last_try = 0;
	struct stat sb;
	int retries = 0;
#endif

	DBM_TYPE dbf;
	DBM_MODE_TYPE imode;

	if (filename == NULL) {
		php3_error(E_WARNING, "NULL filename passed to _php3_dbmopen()");
		return NULL;
	}

	switch (*mode) {
		case 'w': 
			imode = DBM_WRITE_MODE;
			lock = 1;
			break;
		case 'c': 
			imode = DBM_CREATE_MODE;
			lock = 1;
			break;
		case 'n': 
			imode = DBM_NEW_MODE;
			lock = 1;
			break;
		default: 
			imode = DBM_DEFAULT_MODE;
			lock = 0;
			break;
	}

	if (lock) {
		lockfn = emalloc(strlen(filename) + 5);
		strcpy(lockfn, filename);
		strcat(lockfn, ".lck");

#if NFS_HACK 
		while((last_try = stat(lockfn,&sb))==0) {
			retries++;
			sleep(1);
			if (retries>30) break;
		}	
		if (last_try!=0) {
			lockfd = open(lockfn,O_RDWR|O_CREAT,0644);
			close(lockfd);
		} else {
			php3_error(E_WARNING, "File appears to be locked [%s]\n",lockfn);
			return -1;
		}
#else /* NFS_HACK */

		lockfd = open(lockfn,O_RDWR|O_CREAT,0644);

		if (lockfd) {
#if HAVE_LOCKF 
			lockf(lockfd,F_LOCK,0);
#else
#if HAVE_FLOCK 
			flock(lockfd,LOCK_EX);
#endif 
#endif 
			close(lockfd);
		} else {
			php3_error(E_WARNING, "Unable to establish lock: %s",filename);
		}
#endif /* else NFS_HACK */

	}
	dbf = DBM_OPEN(filename, imode);

#if !NDBM && !GDBM
	if (dbf) {
		setvbuf(dbf, NULL, _IONBF, 0);
	}	
#endif

	if (dbf) {
		info = (dbm_info *)emalloc(sizeof(dbm_info));
		if (!info) {
			php3_error(E_ERROR, "problem allocating memory!");
			return NULL;
		}

		info->filename = estrdup(filename);
		info->lockfn = lockfn;
		info->lockfd = lockfd;
		info->dbf = dbf;

		return info;
	} else {
#if GDBM 
		php3_error(E_WARNING, "dbmopen_gdbm(%s): %d [%s], %d [%s]",filename,gdbm_errno,gdbm_strerror(gdbm_errno),errno,strerror(errno));
		if (gdbm_errno)
			ret = gdbm_errno;
		else if (errno)
			ret = errno;
		else
			ret = -1;
#else 
#if NDBM 
#if DEBUG
		php3_error(E_WARNING, "dbmopen_ndbm(%s): errno = %d [%s]\n",filename,errno,strerror(errno));
#endif
		if (errno) ret=errno;
		else ret = -1;
#else
#if DEBUG
		php3_error(E_WARNING, "dbmopen_flatfile(%s): errno = %d [%s]\n",filename,errno,strerror(errno));
#endif
		if (errno) ret=errno;
		else ret = -1;
#endif 
#endif 	

#if NFS_HACK
		if (lockfn) {
			unlink(lockfn);
		}
#endif
		if (lockfn) efree(lockfn);
	}

	return NULL;
}

void php3_dbmclose(INTERNAL_FUNCTION_PARAMETERS) {
	pval *id;

	if (ARG_COUNT(ht) != 1 || getParameters(ht,1,&id)==FAILURE) {
		WRONG_PARAM_COUNT;
	}
	convert_to_long(id);

	if (php3_list_delete(id->value.lval) == SUCCESS) {
		RETURN_TRUE;
	} else {
		RETURN_FALSE;
	}
}

int _php3_dbmclose(dbm_info *info) {
	int ret = 0;
	DBM_TYPE dbf;
	int lockfd;

	dbf = info->dbf;

#if NFS_HACK
	unlink(info->lockfn);
#else
	if (info->lockfn) {
		lockfd = open(info->lockfn,O_RDWR,0644);
#if HAVE_LOCKF
		lockf(lockfd,F_ULOCK,0);
#else
# if HAVE_FLOCK
		flock(lockfd,LOCK_UN);
# endif
#endif
		close(lockfd);
	}
#endif

	if (dbf)
		DBM_CLOSE(dbf);

	/* free the memory used by the dbm_info struct */
	if (info->filename) efree(info->filename);
	if (info->lockfn) efree(info->lockfn);
	efree(info);

	return(ret);
}	

/*
 * ret = -1 means that database was opened for read-only
 * ret = 0  success
 * ret = 1  key already exists - nothing done
 */
void php3_dbminsert(INTERNAL_FUNCTION_PARAMETERS)
{
	pval *id, *key, *value;
	dbm_info *info;
	int ret;

	if (ARG_COUNT(ht)!=3||getParameters(ht,3,&id,&key,&value) == FAILURE) {
		WRONG_PARAM_COUNT;
	}
	convert_to_string(key);
	convert_to_string(value);

	info = _php3_finddbm(id,list);
	if (!info) {
		php3_error(E_WARNING, "not a valid database identifier %d", id->value.lval);
		RETURN_FALSE;
	}
	
	ret = _php3_dbminsert(info, key->value.str.val, value->value.str.val);
	RETURN_LONG(ret);
}

int _php3_dbminsert(dbm_info *info, char *key, char *value) {
	datum key_datum, value_datum;
	int ret;
	DBM_TYPE dbf;

	_php3_stripslashes(key,NULL);
	_php3_stripslashes(value,NULL);

	value_datum.dptr = estrdup(value);
	value_datum.dsize = strlen(value);

	key_datum.dptr = estrdup(key);
	key_datum.dsize = strlen(key);
#if GDBM_FIX
	key_datum.dsize++;
#endif

	dbf = info->dbf;
	if (!dbf) {
		php3_error(E_WARNING, "Unable to locate dbm file");
		return 1;
	}

	ret = DBM_STORE(dbf, key_datum, value_datum, DBM_INSERT);

	/* free the memory */
	efree(key_datum.dptr); efree(value_datum.dptr);

	return(ret);	
}	

void php3_dbmreplace(INTERNAL_FUNCTION_PARAMETERS)
{
	pval *id, *key, *value;
	dbm_info *info;
	int ret;

	if (ARG_COUNT(ht)!=3||getParameters(ht,3,&id,&key,&value) == FAILURE) {
		WRONG_PARAM_COUNT;
	}
	convert_to_string(key);
	convert_to_string(value);

	info = _php3_finddbm(id,list);
	if (!info) {
		php3_error(E_WARNING, "not a valid database identifier %d", id->value.lval);
		RETURN_FALSE;
	}
	
	ret = _php3_dbmreplace(info, key->value.str.val, value->value.str.val);
	RETURN_LONG(ret);
}

int _php3_dbmreplace(dbm_info *info, char *key, char *value) {
	DBM_TYPE dbf;
	int ret;
	datum key_datum, value_datum;

	if (php3_ini.magic_quotes_runtime) {
		_php3_stripslashes(key,NULL);
		_php3_stripslashes(value,NULL);
	}

	value_datum.dptr = estrdup(value);
	value_datum.dsize = strlen(value);

	key_datum.dptr = estrdup(key);
	key_datum.dsize = strlen(key);
#if GDBM_FIX
	key_datum.dsize++;
#endif

	dbf = info->dbf;
	if (!dbf) {
		php3_error(E_WARNING, "Unable to locate dbm file");
		return 1;
	}

	ret = DBM_STORE(dbf, key_datum, value_datum, DBM_REPLACE);

	/* free the memory */
	efree(key_datum.dptr); efree(value_datum.dptr);

	return(ret);	
}	

void php3_dbmfetch(INTERNAL_FUNCTION_PARAMETERS)
{
	pval *id, *key;
	dbm_info *info;

	if (ARG_COUNT(ht)!=2||getParameters(ht,2,&id,&key)==FAILURE) {
		WRONG_PARAM_COUNT;
	}
	convert_to_string(key);

	info = _php3_finddbm(id,list);
	if (!info) {
		php3_error(E_WARNING, "not a valid database identifier %d", id->value.lval);
		RETURN_FALSE;
	}

	return_value->value.str.val = _php3_dbmfetch(info, key->value.str.val);
	if (return_value->value.str.val) {
		return_value->value.str.len = strlen(return_value->value.str.val);
		return_value->type = IS_STRING;
	} else {
		RETURN_FALSE;
	}
}

char *_php3_dbmfetch(dbm_info *info, char *key) {
	datum key_datum, value_datum;
	char *ret;
	DBM_TYPE dbf;

	key_datum.dptr = key;
	key_datum.dsize = strlen(key);
#if GDBM_FIX
	key_datum.dsize++;
#endif
	value_datum.dptr = NULL;
	value_datum.dsize = 0;

	dbf = info->dbf;
	if (!dbf) {
		php3_error(E_WARNING, "Unable to locate dbm file");
		return(NULL);
	}

	value_datum = DBM_FETCH(dbf, key_datum);

	if (value_datum.dptr) {
		ret = (char *)emalloc(sizeof(char) * value_datum.dsize + 1);
		strncpy(ret, value_datum.dptr, value_datum.dsize);
		ret[value_datum.dsize] = '\0';

#if GDBM
/* all but NDBM use malloc to allocate the content blocks, so we need to free it */
		free(value_datum.dptr);
#else
# if !NDBM
		efree(value_datum.dptr);
# endif
#endif
	}
	else
		ret = NULL;

	if (ret && php3_ini.magic_quotes_runtime) {
		ret = _php3_addslashes(ret, value_datum.dsize, NULL, 1);
	}
	return(ret);
}


void php3_dbmexists(INTERNAL_FUNCTION_PARAMETERS)
{
	pval *id, *key;
	dbm_info *info;
	int ret;

	if (ARG_COUNT(ht)!=2||getParameters(ht,2,&id,&key)==FAILURE) {
		WRONG_PARAM_COUNT;
	}
	convert_to_string(key);

	info = _php3_finddbm(id,list);
	if (!info) {
		php3_error(E_WARNING, "not a valid database identifier %d", id->value.lval);
		RETURN_FALSE;
	}

	ret = _php3_dbmexists(info, key->value.str.val);
	RETURN_LONG(ret);
}

int _php3_dbmexists(dbm_info *info, char *key) {
	datum key_datum;
	int ret;
	DBM_TYPE dbf;

	key_datum.dptr = key;
	key_datum.dsize = strlen(key);
#if GDBM_FIX
	key_datum.dsize++;
#endif

	dbf = info->dbf;
	if (!dbf) {
		php3_error(E_WARNING, "Unable to locate dbm file");
		return(0);
	}

	ret = DBM_EXISTS(dbf, key_datum);

	return(ret);
}
		
void php3_dbmdelete(INTERNAL_FUNCTION_PARAMETERS)
{
	pval *id, *key;
	dbm_info *info;
	int ret;

	if (ARG_COUNT(ht)!=2||getParameters(ht,2,&id,&key)==FAILURE) {
		WRONG_PARAM_COUNT;
	}
	convert_to_string(key);

	info = _php3_finddbm(id,list);
	if (!info) {
		php3_error(E_WARNING, "not a valid database identifier %d", id->value.lval);
		RETURN_FALSE;
	}

	ret = _php3_dbmdelete(info, key->value.str.val);
	RETURN_LONG(ret);
}

int _php3_dbmdelete(dbm_info *info, char *key) {
	datum key_datum;
	int ret;
	DBM_TYPE dbf;

	key_datum.dptr = key;
	key_datum.dsize = strlen(key);
#if GDBM_FIX
	key_datum.dsize++;
#endif

	dbf = info->dbf;
	if (!dbf) {
		php3_error(E_WARNING, "Unable to locate dbm file");
		return(0);
	}

	ret = DBM_DELETE(dbf, key_datum);
	return(ret);
}

void php3_dbmfirstkey(INTERNAL_FUNCTION_PARAMETERS)
{
	pval *id;
	dbm_info *info;
	char *ret;

	if (ARG_COUNT(ht)!=1||getParameters(ht,1,&id)==FAILURE) {
		WRONG_PARAM_COUNT;
	}

	info = _php3_finddbm(id,list);
	if (!info) {
		php3_error(E_WARNING, "not a valid database identifier %d", id->value.lval);
		RETURN_FALSE;
	}

	ret = _php3_dbmfirstkey(info);
	if (!ret) {
		RETURN_FALSE;
	} else {
		return_value->value.str.val = ret;
		return_value->value.str.len = strlen(ret);
		return_value->type = IS_STRING;
	}
}

char *_php3_dbmfirstkey(dbm_info *info) {
	datum ret_datum;
	char *ret;
	DBM_TYPE dbf;

	dbf = info->dbf;
	if (!dbf) {
		php3_error(E_WARNING, "Unable to locate dbm file");
		return(NULL);
	}

	/* explicitly zero-out ret_datum */
	ret_datum.dptr = NULL;
	ret_datum.dsize = 0;

	ret_datum = DBM_FIRSTKEY(dbf);
	
	if (!ret_datum.dptr)
		return NULL;

	ret = (char *)emalloc((ret_datum.dsize + 1) * sizeof(char));
	strncpy(ret, ret_datum.dptr, ret_datum.dsize);	
	ret[ret_datum.dsize] = '\0';

#if !NDBM & !GDBM
	efree(ret_datum.dptr);
#endif

	return (ret);
}

void php3_dbmnextkey(INTERNAL_FUNCTION_PARAMETERS)
{
	pval *id, *key;
	dbm_info *info;
	char *ret;

	if (ARG_COUNT(ht)!=2||getParameters(ht,2,&id,&key)==FAILURE) {
		WRONG_PARAM_COUNT;
	}
	convert_to_string(key);

	info = _php3_finddbm(id,list);
	if (!info) {
		php3_error(E_WARNING, "not a valid database identifier %d", id->value.lval);
		RETURN_FALSE;
	}

	ret = _php3_dbmnextkey(info, key->value.str.val);
	if (!ret) {
		RETURN_FALSE;
	} else {
		return_value->value.str.val = ret;
		return_value->value.str.len = strlen(ret);
		return_value->type = IS_STRING;
	}
}

char *_php3_dbmnextkey(dbm_info *info, char *key) {
	datum key_datum, ret_datum;
	char *ret;
	DBM_TYPE dbf;

	key_datum.dptr = key;
	key_datum.dsize = strlen(key);
#if GDBM_FIX
	key_datum.dsize++;
#endif

	dbf = info->dbf;
	if (!dbf) {
		php3_error(E_WARNING, "Unable to locate dbm file");
		return(NULL);
	}

	/* explicitly zero-out ret_datum */
	ret_datum.dptr = NULL;
	ret_datum.dsize = 0;

	ret_datum = DBM_NEXTKEY(dbf, key_datum);

	if (ret_datum.dptr) {
		ret = (char *)emalloc(sizeof(char) * ret_datum.dsize + 1);
		strncpy(ret, ret_datum.dptr, ret_datum.dsize);
		ret[ret_datum.dsize] = '\0';
#if GDBM
/* GDBM uses malloc to allocate the value_datum block, so we need to free it */
		free(ret_datum.dptr);
#else
# if !NDBM
		efree(ret_datum.dptr);
# endif
#endif
	}
	else ret=NULL;

	if (ret && php3_ini.magic_quotes_runtime) {
		ret = _php3_addslashes(ret, ret_datum.dsize, NULL, 1);
	}
	return(ret);
}


#if !GDBM && !NDBM
static long CurrentFlatFilePos = 0L;

int flatfile_store(FILE *dbf, datum key_datum, datum value_datum, int mode) {
	int ret;

	if (mode == DBM_INSERT) {
		return 1;
		fseek(dbf,0L,SEEK_END);
		fprintf(dbf,"%d\n",key_datum.dsize);
		fflush(dbf);
		ret = write(fileno(dbf),key_datum.dptr,key_datum.dsize);
		fprintf(dbf,"%d\n",value_datum.dsize);
		fflush(dbf);
		ret = write(fileno(dbf),value_datum.dptr,value_datum.dsize);
	} else { /* DBM_REPLACE */
		flatfile_delete(dbf,key_datum);
		fprintf(dbf,"%d\n",key_datum.dsize);
		fflush(dbf);
		ret = write(fileno(dbf),key_datum.dptr,key_datum.dsize);
		fprintf(dbf,"%d\n",value_datum.dsize);
		ret = write(fileno(dbf),value_datum.dptr,value_datum.dsize);
	}

	if (ret>0)
		ret=0;
	return ret;
}

datum flatfile_fetch(FILE *dbf, datum key_datum) {
	datum value_datum = {NULL, 0};
	int num=0, buf_size=1024;
	char *buf;	

	if (flatfile_findkey(dbf,key_datum)) {
		buf = emalloc((buf_size+1) * sizeof(char));
		if (fgets(buf, 15, dbf)) {
			num = atoi(buf);
			if (num > buf_size) {
				buf_size+=num;
				buf = emalloc((buf_size+1)*sizeof(char));
			}
			read(fileno(dbf),buf,num);
			value_datum.dptr = buf;
			value_datum.dsize = num;
		}
	}
	return value_datum;
}

int flatfile_delete(FILE *dbf, datum key_datum) {
	char *key = key_datum.dptr;
	int size = key_datum.dsize;

	char *buf;
	int num, buf_size = 1024;
	long pos;

	rewind(dbf);

	buf = emalloc((buf_size + 1)*sizeof(char));
	while(!feof(dbf)) {
		/* read in the length of the key name */
		if (!fgets(buf, 15, dbf))
			break;
		num = atoi(buf);
		if (num > buf_size) {
			buf_size += num;
			if (buf) efree(buf);
			buf = emalloc((buf_size+1)*sizeof(char));
		}
		pos = ftell(dbf);

		/* read in the key name */
		num = fread(buf, sizeof(char), num, dbf);
		if (num<0) break;
		*(buf+num) = '\0';

		if (size == num && !memcmp(buf, key, size)) {
			fseek(dbf, pos, SEEK_SET);
			fputc(0, dbf);
			fflush(dbf);
			fseek(dbf, 0L, SEEK_END);
			if (buf) efree(buf);
			return SUCCESS;
		}	

		/* read in the length of the value */
		if (!fgets(buf,15,dbf))
			break;
		num = atoi(buf);
		if (num > buf_size) {
			buf_size+=num;
			if (buf) efree(buf);
			buf = emalloc((buf_size+1)*sizeof(char));
		}
		/* read in the value */
		num = fread(buf, sizeof(char), num, dbf);
		if (num<0)
			break;
	}
	if (buf) efree(buf);
	return FAILURE;
}	

int flatfile_findkey(FILE *dbf, datum key_datum) {
	char *buf = NULL;
	int num;
	int buf_size=1024;
	int ret=0;
	void *key = key_datum.dptr;
	int size = key_datum.dsize;

	rewind(dbf);
	buf = emalloc((buf_size+1)*sizeof(char));
	while (!feof(dbf)) {
		if (!fgets(buf,15,dbf)) break;
		num = atoi(buf);
		if (num > buf_size) {
			if (buf) efree(buf);
			buf_size+=num;
			buf = emalloc((buf_size+1)*sizeof(char));
		}
		num = fread(buf, sizeof(char), num, dbf);
		if (num<0) break;
		*(buf+num) = '\0';
		if (size == num) {
			if (!memcmp(buf,key,size)) {
				ret = 1;
				break;
			}
		}	
		if (!fgets(buf,15,dbf))
			break;
		num = atoi(buf);
		if (num > buf_size) {
			if (buf) efree(buf);
			buf_size+=num;
			buf = emalloc((buf_size+1)*sizeof(char));
		}
		num = fread(buf, sizeof(char), num, dbf);
		if (num<0) break;
		*(buf+num) = '\0';
	}
	if (buf) efree(buf);
	return(ret);
}	

datum flatfile_firstkey(FILE *dbf) {
	datum buf;
	int num;
	int buf_size=1024;

	rewind(dbf);
	buf.dptr = emalloc((buf_size+1)*sizeof(char));
	while(!feof(dbf)) {
		if (!fgets(buf.dptr,15,dbf)) break;
		num = atoi(buf.dptr);
		if (num > buf_size) {
			buf_size+=num;
			if (buf.dptr) efree(buf.dptr);
			buf.dptr = emalloc((buf_size+1)*sizeof(char));
		}
		num=read(fileno(dbf),buf.dptr,num);
		if (num<0) break;
		buf.dsize = num;
		if (*(buf.dptr)!=0) {
			CurrentFlatFilePos = ftell(dbf);
			return(buf);
		}
		if (!fgets(buf.dptr,15,dbf)) break;
		num = atoi(buf.dptr);
		if (num > buf_size) {
			buf_size+=num;
			if (buf.dptr) efree(buf.dptr);
			buf.dptr = emalloc((buf_size+1)*sizeof(char));
		}
		num=read(fileno(dbf),buf.dptr,num);
		if (num<0) break;
	}
	if (buf.dptr) efree(buf.dptr);
	buf.dptr = NULL;
	return(buf);
}	

datum flatfile_nextkey(FILE *dbf) {
	datum buf;
	int num;
	int buf_size=1024;

	fseek(dbf,CurrentFlatFilePos,SEEK_SET);
	buf.dptr = emalloc((buf_size+1)*sizeof(char));
	while(!feof(dbf)) {
		if (!fgets(buf.dptr,15,dbf)) break;
		num = atoi(buf.dptr);
		if (num > buf_size) {
			buf_size+=num;
			if (buf.dptr) efree(buf.dptr);
			buf.dptr = emalloc((buf_size+1)*sizeof(char));
		}
		num=read(fileno(dbf),buf.dptr,num);
		if (num<0) break;
		if (!fgets(buf.dptr,15,dbf)) break;
		num = atoi(buf.dptr);
		if (num > buf_size) {
			buf_size+=num;
			if (buf.dptr) efree(buf.dptr);
			buf.dptr = emalloc((buf_size+1)*sizeof(char));
		}
		num=read(fileno(dbf),buf.dptr,num);
		if (num<0) break;
		buf.dsize = num;
		if (*(buf.dptr)!=0) {
			CurrentFlatFilePos = ftell(dbf);
			return(buf);
		}
	}
	if (buf.dptr) efree(buf.dptr);
	buf.dptr = NULL;
	return(buf);
}	
#endif


int php3_minit_db(INIT_FUNC_ARGS)
{
#ifdef THREAD_SAFE
	dbm_global_struct *dbm_globals;
#if !COMPILE_DL
	CREATE_MUTEX(dbm_mutex,"DBM_TLS");
	SET_MUTEX(dbm_mutex);
	numthreads++;
	if (numthreads==1){
	if ((DbmTls=TlsAlloc())==0xFFFFFFFF){
		FREE_MUTEX(dbm_mutex);
		return 0;
	}}
	FREE_MUTEX(dbm_mutex);
#endif
	dbm_globals = (dbm_global_struct *) LocalAlloc(LPTR, sizeof(dbm_global_struct)); 
	TlsSetValue(DbmTls, (void *) dbm_globals);
#endif

	DBM_GLOBAL(le_db) = register_list_destructors(_php3_dbmclose,NULL);
	return SUCCESS;
}

static int php3_mend_db(void){
#ifdef THREAD_SAFE
	dbm_global_struct *dbm_globals;
	dbm_globals = TlsGetValue(DbmTls); 
	if (dbm_globals != 0) 
		LocalFree((HLOCAL) dbm_globals); 
#if !COMPILE_DL
	SET_MUTEX(dbm_mutex);
	numthreads--;
	if (!numthreads){
	if (!TlsFree(DbmTls)){
		FREE_MUTEX(dbm_mutex);
		return 0;
	}}
	FREE_MUTEX(dbm_mutex);
#endif
#endif
	return SUCCESS;
}

int php3_rinit_db(INIT_FUNC_ARGS) {
#if !GDBM && !NDBM
	CurrentFlatFilePos = 0L;
#endif
	return SUCCESS;
}


function_entry dbm_functions[] = {
	{"dblist",		php3_dblist,		NULL},
	{"dbmopen",		php3_dbmopen,		NULL},
	{"dbmclose",	php3_dbmclose,		NULL},
	{"dbminsert",	php3_dbminsert,		NULL},
	{"dbmfetch",	php3_dbmfetch,		NULL},
	{"dbmreplace",	php3_dbmreplace,	NULL},
	{"dbmexists",	php3_dbmexists,		NULL},
	{"dbmdelete",	php3_dbmdelete,		NULL},
	{"dbmfirstkey",	php3_dbmfirstkey,	NULL},
	{"dbmnextkey",	php3_dbmnextkey,	NULL},
	{NULL,NULL,NULL}
};

php3_module_entry dbm_module_entry = {
	"DBM", dbm_functions, php3_minit_db, php3_mend_db, php3_rinit_db, NULL, php3_info_db, STANDARD_MODULE_PROPERTIES
};

#if COMPILE_DL
DLEXPORT php3_module_entry *get_module(void) { return &dbm_module_entry; }

#if (WIN32|WINNT) && defined(THREAD_SAFE)

/*NOTE: You should have an odbc.def file where you
export DllMain*/
BOOL WINAPI DllMain(HANDLE hModule, 
                      DWORD  ul_reason_for_call, 
                      LPVOID lpReserved)
{
    switch( ul_reason_for_call ) {
    case DLL_PROCESS_ATTACH:
		if ((DbmTls=TlsAlloc())==0xFFFFFFFF){
			return 0;
		}
		break;    
    case DLL_THREAD_ATTACH:
		break;
    case DLL_THREAD_DETACH:
		break;
	case DLL_PROCESS_DETACH:
		if (!TlsFree(DbmTls)){
			return 0;
		}
		break;
    }
    return 1;
}
#endif
#endif

/*
 * Local variables:
 * tab-width: 4
 * c-basic-offset: 4
 * End:
 */
