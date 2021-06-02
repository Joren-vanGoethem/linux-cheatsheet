#!/bin/bash

greeting="welcome"
user=$(whoami)
day=$(date +%A)

echo "$greeting $user, today is $day, this is a test"
