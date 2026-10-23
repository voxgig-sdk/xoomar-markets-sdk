import { XoomarMarketsEntityBase } from '../XoomarMarketsEntityBase';
import type { XoomarMarketsSDK } from '../XoomarMarketsSDK';
import type { Control } from '../types';
import type { Company, CompanyLoadMatch, CompanyListMatch } from '../XoomarMarketsTypes';
declare class CompanyEntity extends XoomarMarketsEntityBase<Company> {
    constructor(client: XoomarMarketsSDK, entopts: any);
    make(this: CompanyEntity): CompanyEntity;
    load(this: any, reqmatch?: CompanyLoadMatch, ctrl?: Control): Promise<CompanyEntity>;
    list(this: any, reqmatch?: CompanyListMatch, ctrl?: Control): Promise<CompanyEntity[]>;
}
export { CompanyEntity };
