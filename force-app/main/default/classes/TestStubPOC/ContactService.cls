public with sharing class ContactService {
  
  ContactSelector conctactSelector;

  public ContactService(ContactSelector conctactSelector) {
    this.conctactSelector = conctactSelector;
  }

  public Integer getContactSize(String email) {
    List<Contact> contacts = conctactSelector.getContactsByEmail(email);

    return contacts.size();
  }

  public String getEmailByContactRecordId(Id contactId) {
    Contact contact = conctactSelector.getContactByRecordId(contactId);

    return contact.Email;
  }
}