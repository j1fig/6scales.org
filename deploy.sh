#!/bin/bash
netlify deploy -d .

while true; do
    read -p "Do you wish to proceed to production?" yn
    case $yn in
        [Yy]* ) netlify deploy --prod -d . ; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


