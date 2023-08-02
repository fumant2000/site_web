<?php


namespace App\Tests\Functional;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;


class BasicTests extends WebTestCase
{
    public function testEnvironmentsIsOk(): void
    {
        $client = static::createClient();
        $client->request(Request::METHOD_GET, "/");
        $this->assertResponseIsSuccessful();
    }
}