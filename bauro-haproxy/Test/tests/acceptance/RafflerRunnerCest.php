<?php

class RafflerRunnerCest {

    public function testFindRafflerWinner(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->reloadPage();
        $visits = rand ( 50 , 200 );
        $i = 0;
        $I->comment('Start raffling :-)');
        while ($visits > $i) {
            $I->reloadPage();
            $i++;
        }
        $winner = $I->grabTextFrom('h1');
        $I->comment('Winner is ' . $winner);
    }
}