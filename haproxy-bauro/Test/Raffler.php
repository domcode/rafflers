<?php

include_once "vendor/autoload.php";

class ExampleTest extends \PHPUnit_Framework_TestCase {
    /**
     * @var \Behat\Mink\Session
     */
    protected $session;

    public function setUp() {
        $driver = new \Behat\Mink\Driver\GoutteDriver();
        $this->session = new \Behat\Mink\Session($driver);
        $this->session->start();
    }

    public function tearDown() {
        $this->session->stop();
    }

    public function testExample() {
        $this->session->visit('localhost');
        $page = $this->session->getPage();
        $this->session->
        $this->assertEquals(
            'Mink is a php 5.3 library that you’ll use inside your test suites or project. Before you begin, ensure that you have at least PHP 5.3.1 installed.',
            $page->find('css', 'h1')->getText()
        );
    }
}