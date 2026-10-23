import { XoomarMarketsEntityBase } from '../XoomarMarketsEntityBase';
import type { XoomarMarketsSDK } from '../XoomarMarketsSDK';
import type { Control } from '../types';
import type { Crypto, CryptoLoadMatch, CryptoListMatch } from '../XoomarMarketsTypes';
declare class CryptoEntity extends XoomarMarketsEntityBase<Crypto> {
    constructor(client: XoomarMarketsSDK, entopts: any);
    make(this: CryptoEntity): CryptoEntity;
    load(this: any, reqmatch?: CryptoLoadMatch, ctrl?: Control): Promise<CryptoEntity>;
    list(this: any, reqmatch?: CryptoListMatch, ctrl?: Control): Promise<CryptoEntity[]>;
}
export { CryptoEntity };
