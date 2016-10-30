#!/usr/bin/env bash
exec varnishd -j unix,user=varnish -F -a 0.0.0.0:$LISTEN_PORT -f $VCL_CONFIG
