/**
 * @description       : 
 * @author            : Huseyin
 * @group             : 
 * @last modified on  : 08-25-2022
 * @last modified by  : Huseyin
**/
import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {

    showHandler1(event){
        console.log("Parent Comp: onshow event in c-child-comp");
        console.log(event.target.nodeName);
        console.log(event.currentTarget.nodeName);
    }
    showHandler2(event){
        console.log("Parent Comp: onshow event in div");
        console.log(event.target.nodeName);
        console.log(event.currentTarget.nodeName);
    }
}