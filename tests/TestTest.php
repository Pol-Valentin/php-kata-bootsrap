<?php
declare(strict_types=1);

namespace Kata\Tests;


use Kata\Test;
use PHPUnit\Framework\TestCase;

final class TestTest extends TestCase
{
    /** @test */
    public function it_tests(): void
    {
        self::assertTrue(Test::test());
    }
}
