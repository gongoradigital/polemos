#!/bin/sh
BASEDIR=$(dirname $0)
# pour les noms de fichiers avec accents
export LC_CTYPE=fr_FR.UTF-8
/usr/bin/svn --non-interactive --trust-server-cert  update $BASEDIR/ 2>&1
/usr/bin/php $BASEDIR/../teipub/Teipub.php  "$BASEDIR/xml/*.xml"  "$BASEDIR/gongora.sqlite" 2>&1
exit 0
