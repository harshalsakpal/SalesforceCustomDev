public with sharing class ContactSelector {

  public List<Contact> getContactsByEmail(String email) {
    List<Contact> contacts = null;
    if(String.isNotBlank(email)){
      contacts = new List<Contact>();
      contacts = [SELECT Id, FirstName, LastName, Name, Email, Phone 
                  FROM Contact 
                  WHERE Email = :email
                  ];
    }
    return contacts;
  }

  public Contact getContactByRecordId(Id recordId) {
    Contact contact = null;
    if(recordId != null) {
      contact = [SELECT Id, FirstName, LastName, Name, Email, Phone 
                  FROM Contact 
                  WHERE Id = :recordId
                  ];
    }
    return contact;
  }
}