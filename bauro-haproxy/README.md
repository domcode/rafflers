So what is the stuff here
-------------------------

The vagrant box contains a haproxy setup and every name gets is own apache site configured with a unique port.
When the vagrant box is up and running a acceptance test will be runned that visits the website multiple times at random
The name that is showed when the acceptance test is finished is the winner.

Requirements
------------

### ansible & Vagrant

Raffle
------
The default file for the raffle is `../example_names` and you can run the raffle like:

    run.sh
    
If you want you can give another file path as a argument like:

    run.sh ../example_names
