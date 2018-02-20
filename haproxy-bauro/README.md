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
    
How is the raffling work
------------------------

        public function testFindRafflerWinner(AcceptanceTester $I)
        {
            $I->amOnPage('/');
            $visits = rand ( 50 , 1000 );
            $i = 0;
            while ($visits > $i) {
                $I->reloadPage();
                $i++;
            }
            $winner = $I->grabTextFrom('h1');
            $file = fopen("/vagrant/winner.txt","w");
            fwrite($file, PHP_EOL . "The winner is: " . $winner . PHP_EOL);
            fclose($file);
        }
