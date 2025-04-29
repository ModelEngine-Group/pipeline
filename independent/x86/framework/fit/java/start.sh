#!/bin/bash
set -eu

mkdir -p ${LOG_HOME}
chmod 750 ${LOG_HOME}
chmod 750 /log

cp -r /opt/fit-framework/data/share/* /var/share
chmod -R 750 /var/share

mkdir -p /var/share/smart_form
cp -r /opt/fit-framework/data/smart-form/* /var/share/smart_form
cp /opt/appbuilder/form/template.zip /var/share/smart_form
mkdir -p /var/share/smart_form/temporary
chmod -R 750 /var/share/smart_form

../bin/fit start
