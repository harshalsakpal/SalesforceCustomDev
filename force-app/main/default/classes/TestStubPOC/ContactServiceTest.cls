@isTest(isParallel=true)
private class ContactServiceTest {
  
  @isTest
  static void testGetContactSize() {

    List<Contact> contacts = new List<Contact>();

    Contact contact1 = new Contact(FirstName = 'MockFName1', LastName = 'MockLName1', Email = 'mockEmail@example.com');
    Contact contact2 = new Contact(FirstName = 'MockFName2', LastName = 'MockLName2', Email = 'mockEmail@example.com');
    contacts.add(contact1);
    contacts.add(contact2);

    CustomStubProvider stub = new CustomStubProvider(ContactSelector.class);
    CustomStubProvider.Method methodToTrack = new CustomStubProvider.Method('getContactsByEmail')
        .returning(contacts);

    stub.track(methodToTrack);

    ContactService contactSvc = new ContactService((ContactSelector) stub.generate());

    Test.startTest();

      Integer contactCount = contactSvc.getContactSize('mockEmail@example.com');
      
    Test.stopTest();

    System.assertEquals(2, contactCount, 'Mock ContactSelector was not not generated.');
  }

  @isTest
  static void testGetEmailByContactRecordId() {
    String mockedEmail = 'mockEmail@example.com';
    
    Contact contact = new Contact(Id = '003000000000001', FirstName = 'MockFName1', LastName = 'MockLName1', Email = mockedEmail);

    CustomStubProvider stub = new CustomStubProvider(ContactSelector.class);
    CustomStubProvider.Method methodToTrack = new CustomStubProvider.Method('getContactByRecordId')
        .returning(contact);

    stub.track(methodToTrack);

    ContactService contactSvc = new ContactService((ContactSelector) stub.generate());
    
    Test.startTest();

      String emailResult = contactSvc.getEmailByContactRecordId(contact.Id);

    Test.stopTest();
    
    System.assertEquals(mockedEmail, emailResult, 'Mock ContactSelector was not not generated.');
  }

}