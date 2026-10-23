<?php
declare(strict_types=1);

// XoomarMarkets SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class XoomarMarketsMakeContext
{
    public static function call(array $ctxmap, ?XoomarMarketsContext $basectx): XoomarMarketsContext
    {
        return new XoomarMarketsContext($ctxmap, $basectx);
    }
}
