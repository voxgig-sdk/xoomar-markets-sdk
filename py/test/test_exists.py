# XoomarMarkets SDK exists test

import pytest
from xoomarmarkets_sdk import XoomarMarketsSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = XoomarMarketsSDK.test(None, None)
        assert testsdk is not None
