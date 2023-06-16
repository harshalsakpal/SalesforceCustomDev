@isTest(isParallel=true)
private class OrgUtilTest {

    @isTest
    static void testIsProdWithoutStaticVar() {

        Test.startTest();

            Boolean isProd = OrgUtil.isProd();

        Test.stopTest();

        Organization org = [SELECT IsSandbox FROM Organization LIMIT 1];

        Assert.isTrue(isProd == !org.IsSandbox, 'OrgUtil.isProd returned ' + isProd + ' expected: '+(!org.IsSandbox));
    }

    @isTest
    static void testIsProdWithStaticVar() {

        Organization testOrg = [SELECT IsSandbox FROM Organization LIMIT 1];
        OrgUtil.org = testOrg;

        Test.startTest();

            Boolean isProd = OrgUtil.isProd();

        Test.stopTest();

        Assert.isTrue(isProd == !testOrg.IsSandbox, 'OrgUtil.isProd returned ' + isProd + ' expected: '+(!testOrg.IsSandbox));
    }    
}