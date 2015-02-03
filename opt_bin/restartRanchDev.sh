#! /bin/bash

set -e

cd $(dirname $0)/
./safteyChecks.sh

boot2Docker up 1> /dev/null
$(boot2Docker shellinit 1> /dev/null)
mysql.server start 1> /dev/null
mysql -uroot < ./delDatabase.sql 1> /dev/null
mysql -uroot < $CATTLE_ROOT/resources/content/db/mysql/create_db_and_user_dev.sql 1> /dev/null
cd $CATTLE_ROOT/tests/integration
rm -rf .venv
rm -rf .tox
virtualenv .venv 1> /dev/null
. .venv/bin/activate 1> /dev/null
pip install -r test-requirements.txt 1> /dev/null
pip install -r requirements.txt 1> /dev/null
pip install tox 1> /dev/null 
$CATTLE_ROOT/tools/development/register-boot2docker.sh
echo Restarted
