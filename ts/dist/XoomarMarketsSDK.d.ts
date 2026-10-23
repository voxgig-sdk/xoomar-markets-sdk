import { CompanyEntity } from './entity/CompanyEntity';
import { CryptoEntity } from './entity/CryptoEntity';
import { MacroEntity } from './entity/MacroEntity';
export type * from './XoomarMarketsTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { XoomarMarketsEntityBase } from './XoomarMarketsEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
type DirectResult = {
    ok: false;
    err: any;
    status?: undefined;
    headers?: undefined;
    data?: undefined;
} | {
    ok: boolean;
    status: number;
    headers: any;
    data: any;
    err?: any;
};
declare class XoomarMarketsSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<DirectResult>;
    _rawRequest(fetchargs?: any): Promise<DirectResult>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    Company(entopts?: Record<string, any>): CompanyEntity;
    Crypto(entopts?: Record<string, any>): CryptoEntity;
    Macro(entopts?: Record<string, any>): MacroEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): XoomarMarketsSDK;
    tester(testopts?: any, sdkopts?: any): XoomarMarketsSDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof XoomarMarketsSDK;
export { stdutil, config, BaseFeature, XoomarMarketsEntityBase, XoomarMarketsSDK, SDK, };
export type { DirectResult };
