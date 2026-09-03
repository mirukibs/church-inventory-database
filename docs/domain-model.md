# Domain Model

## Context

Our church faces a problem of having to manage equipment of different types, scattered across different departments, custodians and locations within the church. An equipment management system is required to properly track the equipment and activities related to them, but to achieve that, a thorough database of all equipment is required.

The problem is not simply knowing what equipment the church owns. The church needs to know **what equipment exists, where it is, who is responsible for it, what condition it is in, how it was acquired, how it is being used, what has happened to it over time, and what resources are required to maintain and operate it**.

Equipment may also move between departments, locations, individuals and even outside the church premises. Equipment may be borrowed for events, sent for maintenance, damaged, lost, retired or disposed of. Therefore, the system must preserve the history of these activities rather than only showing the equipment's current state.

The church also uses items that are not necessarily long-term assets. Consumable and stock items such as batteries, cables, connectors, cartridges, cleaning materials and other supplies need to be managed separately because they are repeatedly received, issued, transferred, consumed and replenished.

---

## Domain

### The Church

The church consists of several departments and groups that interact with equipment in different ways:

1. **Media and ICT** — comprising all media, computer, networking, internet, streaming, photography and videography infrastructure.

2. **Sound and Music** — comprising the church's sound infrastructure, choir groups, musicians and other personnel involved in music and audio production.

3. **Ushers** — responsible for the general custody and coordination of church facilities and equipment, particularly equipment and records relating to the main church premises.

4. **Pastor's Office** — comprising pastors and the council of elders. This department primarily has an administrative and oversight role and requires information and reports about church equipment rather than directly managing most of it.

These departments may have their own equipment, but responsibility for equipment can change over time. An item may belong to one department while being physically located in another location or temporarily assigned to an individual.

### The Ushers

Ushers are the overall custodians of the church and are among the main actors in the equipment domain.

They interact with computers in their office, furniture in the main hall where the congregation sits, and other equipment used in the general operation of the church. They are also the main keepers of church records, including the main equipment register.

The ushers may therefore be responsible for recording equipment, assigning equipment to responsible individuals or departments, recording movements, receiving returned equipment, reporting damage or loss, and maintaining accurate records of what the church currently possesses.

### Media and ICT

This department is the main custodian of digital technologies and technical infrastructure.

Its equipment includes computers, cameras, video equipment, streaming equipment, networking equipment, internet infrastructure, storage devices, software-related resources and other technology used for media production and information technology.

Media and ICT personnel may be assigned individual equipment and may also manage equipment that is shared among several people. Some equipment may be taken outside the church for events, recordings, conferences or other activities, requiring its movement and temporary custody to be recorded.

### Sound and Music

This department handles equipment concerning the church's sound and music infrastructure.

This includes microphones, speakers, mixers, amplifiers, PA systems, cables, musical instruments and other audio equipment.

Equipment may be assigned to particular musicians, choir groups, sound engineers or other responsible personnel. Some equipment may be shared and therefore needs to be tracked through borrowing, issuing and returning rather than permanent assignment.

### Pastor's Office

The pastor's office mostly consumes what has already been set up and is not the main custodian of technical equipment.

Its primary role is administrative and supervisory. Pastors and the council of elders require reliable information about the church's assets, their value, condition, location, ownership or custody, maintenance, losses and other activities.

The department therefore requires reports that can support decision-making, budgeting, procurement and accountability.

---

## The Equipment

Different equipment categories exist. We have electronic equipment such as digital cameras and computers, non-electronic equipment such as furniture, and electrical equipment such as generators and other electrical infrastructure.

Within these broad categories there are further categories and types. For example, electronic equipment may include computers, cameras, networking equipment and audio equipment. Sound equipment may include microphones, mixers, amplifiers and speakers. Non-electronic equipment may include chairs, tables and cabinets.

The system therefore needs to distinguish between an **equipment type** and an **individual physical equipment item**. For example, "wireless microphone" describes a type of equipment, while a particular wireless microphone owned by the church is an individual item that can have its own identifier, condition, location and history.

Each equipment item has information that needs to be maintained, including its identifying information, monetary value, acquisition date, current condition and current status.

Equipment can have different statuses throughout its life. It may be procured, received, stored, assigned, in use, under maintenance, returned to storage, retired or eventually disposed of. The system should preserve the history of these changes rather than only recording the current status.

---

## Equipment Custody and Assignment

Equipment can have different custodians depending on how it is being used.

An item may be under the general responsibility of a department but assigned to a specific individual. For example, a camera may belong to Media and ICT while being assigned to a particular photographer.

Assignments must therefore record who received the equipment, which department they belong to, when the assignment began, and when it ended.

When equipment changes hands, the previous assignment should not simply be overwritten. The history of previous custodians and assignments must remain available so that the church can determine who was responsible for an item at a particular point in time.

The condition of equipment when it is assigned and when it is returned should also be recorded. This makes it possible to determine whether an item's condition changed while under someone's custody.

---

## Locations and Equipment Movement

Equipment exists in physical locations. These may include the main sanctuary, media room, sound room, offices, storage rooms, choir rooms and other areas within the church.

Equipment may move between locations or departments. Some equipment may also temporarily leave the church premises for events, conferences, recordings, outreach activities or other purposes.

When equipment moves, the system should record the movement, including:

* the equipment being moved;
* its previous location;
* its destination;
* who took responsibility for it;
* when it left;
* when it was expected to return;
* when it actually returned;
* the purpose of the movement; and
* the condition of the equipment.

The system must preserve this movement history because the current location alone is not enough to explain where an item has been or who was responsible for it in the past.

---

## Borrowing and Equipment Usage

Not all equipment is permanently assigned to one person or department.

Some equipment may be requested for a particular event, service, project or activity. A person may request equipment, have the request approved, receive the equipment, use it and later return it.

The church therefore needs to track the borrowing process from the initial request through approval, issuing, usage, return and inspection.

For example, someone may request a camera for an external event. The request should identify the person, purpose, equipment required, expected period of use and destination. Once approved, the equipment is issued to that person and its custody is temporarily transferred.

When it is returned, the church should be able to inspect its condition and determine whether it was returned on time and in the expected condition.

---

## Procurement and Acquisition

Procurement is another important part of the equipment lifecycle because equipment must first enter the church before it can be managed.

The church may acquire equipment through different means, including purchasing, donations, ministry projects, grants or other sources.

For purchased equipment, information such as the supplier, purchase price, purchase date, invoice or reference number and funding source may need to be recorded.

For donated equipment, information about the source of the donation may be relevant even though there is no conventional purchase transaction.

The system should therefore record not only the equipment itself but also **how it entered the church, when it was acquired and the financial or organizational source associated with the acquisition**.

Where equipment has a warranty, warranty information should also be retained so that the church can determine whether repairs or replacements may be covered.

---

## Maintenance and Repairs

Equipment requires maintenance throughout its useful life.

An equipment item may develop a problem, require routine maintenance, be sent to a technician or service provider, receive replacement parts or undergo repairs.

The system should record maintenance activities, including the equipment involved, the problem reported, the date it was reported, the diagnosis, the work performed, the technician or service provider, the cost, the dates the equipment entered and left maintenance, and its condition after the work.

Maintenance history is important because the church should be able to determine how often an item requires maintenance, how much has been spent maintaining it, and whether an item is becoming too expensive or unreliable to keep.

Some equipment may also have scheduled or preventive maintenance requirements, meaning that future maintenance activities need to be planned rather than waiting for equipment to fail.

---

## Consumables and Stock

Not everything used by the church should be treated as a permanent equipment asset.

The church also uses consumable and stock items such as batteries, cables, connectors, printer cartridges, cleaning materials, electrical components, tapes, adapters and other supplies.

Unlike equipment assets, these items are continuously received, issued, consumed, returned, transferred, lost or replenished.

The church therefore needs to know how much stock is currently available, where it is stored, who received it and how the quantity has changed over time.

Stock movements should be recorded so that the current quantity can be determined from the history of receipts, issues, returns, transfers, adjustments, losses and damage.

---

## Damage, Loss and Disposal

Equipment may be damaged, lost, stolen, misplaced or become unusable.

When such an incident occurs, the church needs to record what happened rather than simply changing the equipment's status.

An incident may include the equipment involved, the date, location, person who reported it, person responsible for the equipment at the time, description of what happened, estimated financial loss, investigation and eventual resolution.

Equipment that can no longer be used may eventually be retired and disposed of. The disposal should also be recorded so that the church can distinguish between equipment that is still owned and equipment that has formally left the church's assets.

---

## Equipment History and Accountability

The church needs historical information about equipment, not just its current state.

For any equipment item, the church should be able to determine:

* when it was acquired;
* how it was acquired;
* where it has been;
* which departments have used it;
* who has been responsible for it;
* when it was assigned or borrowed;
* what condition it was in at different points;
* what maintenance it has received;
* what incidents have occurred;
* how much has been spent maintaining it;
* when and why it was eventually retired or disposed of.

This history provides accountability and allows the church to understand the complete lifecycle of its equipment.

---

## Records, Reporting and Oversight

The church's equipment information needs to support both operational activities and management decisions.

Operational users need to know what equipment is available, where it is, who has it and whether it can be used.

Management needs broader reports such as the total value of equipment, equipment by department, equipment requiring maintenance, equipment currently outside the church, lost or damaged equipment, maintenance expenditure and equipment approaching retirement.

The system should therefore provide reliable information for both day-to-day equipment management and higher-level decision-making.

---

## Security and Accountability of Records

Not every person should be able to perform every equipment-related activity.

Different users may have different responsibilities. For example, an inventory manager may maintain equipment records, a storekeeper may manage stock, a department manager may approve requests, an auditor may inspect records, and a read-only user may only view reports.

The system therefore needs to control who can view, create, modify or delete information.

Changes to important records should also be traceable so that the church can determine **who made a change, what was changed and when it was changed**.

This is particularly important for financial information, equipment custody, stock quantities, asset status, incidents and other records where accountability matters.

---

## The Core Domain Problem

At its core, the domain is about **accountability and visibility over the church's physical resources throughout their lifecycle**.

The church needs to maintain a reliable record of what it has, how it acquired it, where it is, who is responsible for it, how it is being used, what condition it is in, what has happened to it, what it costs to maintain, and what ultimately happens to it.

The database therefore represents not merely an equipment list, but the **history and relationships surrounding the church's equipment and resources**.
