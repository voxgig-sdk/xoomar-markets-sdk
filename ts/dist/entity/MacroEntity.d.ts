import { XoomarMarketsEntityBase } from '../XoomarMarketsEntityBase';
import type { XoomarMarketsSDK } from '../XoomarMarketsSDK';
import type { Control } from '../types';
import type { Macro, MacroLoadMatch, MacroListMatch } from '../XoomarMarketsTypes';
declare class MacroEntity extends XoomarMarketsEntityBase<Macro> {
    constructor(client: XoomarMarketsSDK, entopts: any);
    make(this: MacroEntity): MacroEntity;
    load(this: any, reqmatch?: MacroLoadMatch, ctrl?: Control): Promise<MacroEntity>;
    list(this: any, reqmatch?: MacroListMatch, ctrl?: Control): Promise<MacroEntity[]>;
}
export { MacroEntity };
