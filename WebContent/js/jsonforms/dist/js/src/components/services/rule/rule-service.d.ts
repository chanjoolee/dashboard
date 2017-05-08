import { ServiceId } from '../services';
import { IService } from '../services';
import { IPathResolver } from '../pathresolver/jsonforms-pathresolver';
import { IRule } from '../../../jsonforms';
export interface IRuleService extends IService {
    addRuleTrack(ruleServiceCallback: IRuleServiceCallBack): void;
    reevaluateRules(schemaPath: string): void;
}
export interface IRuleServiceCallBack {
    instance: any;
    rule: IRule;
    hide: boolean;
}
export declare class RuleService implements IRuleService {
    private pathresolver;
    private map;
    constructor(pathresolver: IPathResolver);
    getId(): ServiceId;
    reevaluateRules(schemaPath: string): void;
    addRuleTrack(renderDescription: IRuleServiceCallBack): void;
}
