/**
 * This is an org wide utility class, feature wide utility should be in its own utility class.
 */
public without sharing class OrgUtil {

    @TestVisible
    private static Organization org;

    public static Boolean isProd() {

        if(org != null) {

            return !org.IsSandbox;
        }

        org = [SELECT IsSandbox FROM Organization LIMIT 1];

        return !org.IsSandbox;
    }
}