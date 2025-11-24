# SAP ABAP – Sales Order Management Module Pool Application

## Objective
Build a custom transaction to create and display Sales Orders using SAP Module Pool programming, eliminating spreadsheet-based order handling and improving accuracy of header–item data entry.

## Business Problem
The organization needed a controlled internal system for Sales Order entry because manual Excel-based entry caused data inconsistencies, missing validations, and difficulty tracking line items accurately.

## Solution Summary
A multi-screen ABAP Module Pool application that:
1. Accepts a Sales Order Number as input
2. Fetches Header and Item details from custom DDIC tables ZORDH_04 and ZORDIT_04
3. Displays the data using multiple UI components

### UI Components Implemented
| Component | Use in This Application |
|----------|-------------------------|
| Subscreen | Display Sales Order header dynamically |
|  Tab Strip | Navigate between General / Delivery / Pricing etc. |
| Table Control | Enter and update multiple item records |
| Modal Dialog Box | Pop-up for item details / confirmation |

### Functional Flow
1. Input Sales Order Number → Validate
2. Fetch Header + Item data from ZORDH_04 / ZORDIT_04
3. Display Header in subscreen + modal dialog box for popup + tabs for different sections
4. Display Items via table control with full validations

### Technical Highlights
- End-to-end DDIC integration (ZORDH_04 header + ZORDIT_04 item tables)
- PBO/PAI event-driven navigation and validation
- Modular includes with clear separation of screen logic
- GUI Status and OK-Code based user command control
- Rollback mechanism on validation failure to maintain data integrity

## Why This Project Matters
This application simulates real SD business scenarios — not just technical widgets.  
It demonstrates ability to:
- Capture business requirements
- Translate them into SAP UI + DDIC + validation logic
- Build complete applications beyond simple reports

## Screenshots
Screenshots are available under `/screenshots/`, including:
- Table Control Line Items (T. code - ZTC1_04)
- Header Subscreen View (T. code - ZTC2_04)
- Modal Dialog Interaction (T. code - ZTC3_04)
- Tab Strip Navigation (T. code - ZTC4_04)
- Full Integrated Application (T. code - ZTC5_04)

## Data Dictionary Objects
- **ZORDH_04** — Sales Order Header table (OrderNo, Customer, OrderDate, ...)  
- **ZORDIT_04** — Sales Order Item table (OrderNo, Material, Quantity, Price, ...)  
Relationship: ZORDH_04-OrderNo = ZORDIT_04-OrderNo (1-to-many)

## How to Execute
1. Import program in SE80
2. Create transaction code: ( Ex. ZTC_SALES )
3. Execute → Enter Sales Order Number → Display → Save

## Tech Stack
- SAP ABAP | Module Pool Programming
- DDIC (ZORDH_04 / ZORDIT_04)
- Screen Painter (SE51)
- GUI Status / PF-Status / OK-Codes
- PBO / PAI Event Workflow

## Outcome
This complete Module Pool application proves capability to:
- Design SAP UI architecture
- Manage multi-screen data flow
- Handle header–item relationships
- Deliver reliable business logic with clean UX

