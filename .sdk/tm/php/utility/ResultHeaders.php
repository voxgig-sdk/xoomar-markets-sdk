<?php
declare(strict_types=1);

// XoomarMarkets SDK utility: result_headers

class XoomarMarketsResultHeaders
{
    public static function call(XoomarMarketsContext $ctx): ?XoomarMarketsResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
