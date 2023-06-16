/**
 * Helper class which abstracts the implementation of querying constants stored in
 * Custom Metadata Types
*/
public without sharing class GlobalConstantsHelper {

    @TestVisible
    private static final String ORG_TYPE = OrgUtil.isProd() ? 'Prod' : 'Sandbox';

    /**
     * Get value of a constant depending on Sandbox or prod.For one constant there 
     * should be two rows. One for Sandbox and another for production.
    */
    public static String getValueByCategory(String category) {
        String value = null;

        if(String.isBlank(category)) {

            return value;
        }
        List<Global_Constant__mdt> constants = [SELECT Id, Developername, Category__c, 
                                                Key__c, Value__c, Value_Long__c
                                                FROM Global_Constant__mdt
                                                WHERE Category__c = :category
                                                ];
        if(constants.isEmpty() == true) {

            return value;
        }

        if(constants.size() != 2) {

            throw new GlobalConstantsException('Two constants for category ' + category+ ' not found.');
        }
 
        for(Global_Constant__mdt constant: constants) {

            if(constant.Key__c.equalsIgnoreCase(category + ORG_TYPE)) {

                value = String.isNotBlank(constant.Value__c) ? constant.Value__c : constant.Value_Long__c;
            }
        }

        return value;
    }

    public class GlobalConstantsException extends Exception {

    }
}