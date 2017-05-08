import { IPathResolver } from '../services/pathresolver/jsonforms-pathresolver';
import { IUISchemaGenerator } from '../generators/generators';
import { ISchemaGenerator } from '../generators/generators';
import { RendererService } from '../renderers/renderer-service';
import { IUISchemaElement } from '../../jsonforms';
export declare class FormController {
    private rendererService;
    private PathResolver;
    private UISchemaGenerator;
    private SchemaGenerator;
    private $compile;
    private $q;
    private scope;
    static $inject: string[];
    element: any;
    uiSchema: IUISchemaElement;
    private isInitialized;
    private childScope;
    constructor(rendererService: RendererService, PathResolver: IPathResolver, UISchemaGenerator: IUISchemaGenerator, SchemaGenerator: ISchemaGenerator, $compile: ng.ICompileService, $q: ng.IQService, scope: JsonFormsDirectiveScope);
    private static isDataProvider(testMe);
    private static isUiSchemaProvider(testMe);
    init(): void;
    private fetchSchema();
    private fetchUiSchema();
    private fetchData();
}
export interface JsonFormsDirectiveScope extends ng.IScope {
    schema: any;
    uiSchema: any;
    data: any;
}
export declare class JsonFormsDirective implements ng.IDirective {
    restrict: string;
    template: any;
    controller: typeof FormController;
    controllerAs: string;
    scope: {
        schema: string;
        uiSchema: string;
        data: string;
    };
    link: (scope: any, el: any, attrs: any, ctrl: any) => void;
}
export declare class InnerFormController {
    private rendererService;
    private $compile;
    private scope;
    static $inject: string[];
    element: any;
    private uiSchema;
    constructor(rendererService: RendererService, $compile: ng.ICompileService, scope: JsonFormsInnerDirectiveScope);
    init(): void;
}
export interface JsonFormsInnerDirectiveScope extends ng.IScope {
    uiSchema: any;
}
export declare class JsonFormsInnerDirective implements ng.IDirective {
    restrict: string;
    template: any;
    controller: typeof InnerFormController;
    controllerAs: string;
    bindToController: {
        uiSchema: string;
    };
    scope: boolean;
    link: (scope: any, el: any, attrs: any, ctrl: any) => void;
}
