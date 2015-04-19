<?php

class RafflerRunnerCest {

    /**
     * @param AcceptanceTester $I
     */
    public function testFindRafflerWinner(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $visits = rand ( 50 , 1000 );
        $I->seeElement('h1');
        $i = 0;
        while ($visits > $i++) {
            $I->reloadPage();
            $I->seeElement('h1');
        }
        $winner = $I->grabTextFrom('h1');
        $file = fopen("/vagrant/winner.txt","w");
        fwrite($file, PHP_EOL . "The winner is: " . $winner . PHP_EOL);
        fclose($file);
    }
}
