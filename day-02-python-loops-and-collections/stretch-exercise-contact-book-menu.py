"""
Exercise: Contact Book Menu (stretch)
Student: Newana Tandukar
Day: 2
"""

contacts = {}

def get_valid_phone(): # validation for numeric input
    while True:
        phone = input("Enter phone number: ").strip()
        if phone.isdigit():
            return phone
        print("Invalid phone number. Please enter digits only (e.g. 9800000000). Try again.")


def display_menu(): # displays phonebook menu
    print("\n===== Contact Book Menu =====")
    print("1. Add contact")
    print("2. Search contact")
    print("3. Delete contact")
    print("4. Display all contacts")
    print("5. Exit")


def add_contact(): # logic to add contact to list
    name = input("Enter contact name: ").strip()
    phone = get_valid_phone()
    email = input("Enter email address: ").strip()

    contacts[name] = {
        "phone": phone,
        "email": email
    }
    print(f"\nContact '{name}' added successfully.")


def search_contact():  # search and print contact in list
    name = input("Enter name to search: ").strip()

    if name in contacts:
        details = contacts[name]
        print("\n===== Contact Details =====")
        print(f"  Name: {name}\n  Phone: {details['phone']}\n  Email: {details['email']}")
    else:
        print(f"\nNo contact found with the name '{name}'.")


def delete_contact(): # deletes contact from list
    name = input("Enter name to delete: ").strip()

    if name in contacts:
        del contacts[name]
        print(f"\nContact '{name}' deleted successfully.")
    else:
        print(f"\nNo contact found with the name '{name}'. Nothing deleted.")


def display_all_contacts(): # displays list of contacts
    if not contacts:
        print("\nNo contacts saved yet.")
        return

    print("\n===== All Contacts =====")
    for name, details in contacts.items():
        print(f"  Name: {name}\n  Phone: {details['phone']}\n  Email: {details['email']}")

# Main program loop - keeps showing the menu until the user selects Exit (5)
while True:
    display_menu()
    choice = input("Select an option (1-5): ").strip()

    if choice == "1":
        add_contact()
    elif choice == "2":
        search_contact()
    elif choice == "3":
        delete_contact()
    elif choice == "4":
        display_all_contacts()
    elif choice == "5":
        print("\nExiting contact book. Goodbye!")
        break
    else:
        print("\nInvalid option. Please choose a number between 1 and 5.")
