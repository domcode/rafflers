#!/bin/bash
# Appends the CRAN repository to your sources.list file 
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/debianlenny-cran/" >> /etc/apt/sources.list'

# Adds the CRAN GPG key, which is used to sign the R packages for security.
sudo apt-key adv --keyserver subkeys.pgp.net --recv-key 381BA480
sudo apt-get update
sudo apt-get install r-base r-base-dev
