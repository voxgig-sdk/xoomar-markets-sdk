# XoomarMarkets SDK utility: make_context

from projectname_sdk.core.context import XoomarMarketsContext


def make_context_util(ctxmap, basectx):
    return XoomarMarketsContext(ctxmap, basectx)
