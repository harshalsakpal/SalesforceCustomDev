@isTest(isParallel = true)
private class GlobalConstantsHelperTest {

    @isTest
    static void testConstant() {
        
        String constantCategory = 'TestConstant';

        Test.startTest();

            String value = GlobalConstantsHelper.getValueByCategory(constantCategory);

        Test.stopTest();

        Global_Constant__mdt constant = [SELECT Value__c 
                                        FROM Global_Constant__mdt 
                                        WHERE Key__c = :(constantCategory + GlobalConstantsHelper.ORG_TYPE)
                                        ];
        Assert.areEqual(constant.Value__c, value, 'Values were not equal. Check Global_Constant__mdt key '+constantCategory + GlobalConstantsHelper.ORG_TYPE);
    }

    @isTest
    static void testNullInput() {
        
        Test.startTest();

            String value = GlobalConstantsHelper.getValueByCategory(null);

        Test.stopTest();

        Assert.isNull(value, 'Should return null');
    }

    @isTest
    static void testConstantNotPresent() {

        String constantCategory = 'TestConstantThatWillNeverExist' + (Math.random() * 1000);

        Test.startTest();

            String value = GlobalConstantsHelper.getValueByCategory(constantCategory);

        Test.stopTest();

        Assert.isNull(value, 'Should return null');
    }

    @isTest
    static void testException() {

        String constantCategory = 'TestConstantException';
        Boolean caughtGlobalConstantsException = false;

        Test.startTest();

            try {
                String value = GlobalConstantsHelper.getValueByCategory(constantCategory);
            } catch (GlobalConstantsHelper.GlobalConstantsException ex) {

                caughtGlobalConstantsException = true;
            }

        Test.stopTest();

        Assert.isTrue(caughtGlobalConstantsException, 'GlobalConstantsException was not thrown');
    }
}