#!/bin/sh

envsubst '${AGE} ${INDEX}' </actions.yml.tmpl >/actions.yml
envsubst '${ELASTICSEARCH_HOST} ${ELASTICSEARCH_PORT}' </config.yml.tmpl >/config.yml

crond -f
