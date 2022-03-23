#!/bin/bash

source plugins.sh

cd ./bundle
for plugin in "${plugins[@]}"; do
	git clone -q $plugin
done
