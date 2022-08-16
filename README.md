# MDC iOS Coding Challenge

Implemented in Swift & UIKit.

## Dependencies

CocosPods used for third-party libraries, so `pod install` is needed before compiling. 

## Requirements

### List of Incidents

- [x] The list must be scrollable
- [x] Each item will show
  * [x] The incident type icon
  * [x] The incident title
  * [x] The date the incident was last updated
  * [x] A badge indicating the status of the incident
    * Under control: Green background
    * On Scene: Blue background
    * Out of control: Red background
    * Pending: Orange background
- [x] The list is to be sorted by incident last updated date, with an option to change the order (ascending/descending)
- [x] Selecting an incident will show the details
- [x] Show some type of indicator while the incident type icon is loading
- [x] If using SwiftUI, add a search bar (bonus for UIKit)

### Incident Details

- [x] Show each of the following pieces of information, and ensure they are labelled and left-aligned
  * [x] Incident Location
  * [x] Incident Status
  * [x] Incident Type
  * [x] Incident Call Time
  * [x] Incident Description (multi-line)
- [x] Show a map with the incident location
- [x] Display a button to navigate to the incident
- [x] If using SwiftUI, use the incident type icon to represent the location on the map (bonus for UIKit)

### Additional Bonus Tasks

- [x] Ensure the app adapts appropriately when changing between light and dark mode
- [ ] Display the details view as a card view popup instead of pushing to a new page
- [ ] iPad support with a split view/sidebar
- [x] Pull to refresh the incident list
