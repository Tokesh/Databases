/*
Design Phases


▪Initial phase --characterize fully the data needs of the prospective database users.

Second phase  <--choosing  a data model
•Applying the concepts of the chosen data model
•Translating  these requirements into a conceptual schema of the database.
•A fully developed conceptual schema indicates the functional requirements of the enterprise.
▪Describe the kinds of operations (or transactions) that will be performed on the data.

Final Phase <--Moving from an abstract data model to the implementation of the database
•Logical Design –Deciding on the database schema.
▪Database design requires that we find a “good” collection of relation schemas.
▪Business decision –What attributes should we record in the database?
▪Computer Science decision –What relation schemas should we have and how should the attributes be distributed among the various relation schemas?
•Physical Design –Deciding on the physical layout of the database

Entity Relationship Model (ER Modeling) is a graphical approach to database design.
It is a high-level data model that defines data elements and their relationship for a specified software system.
An ER model is used to represent real-world objects
 */


 /*
  Ex 2.
  */

create table Student{
    id VARCHAR PRIMARY KEY,
    name_stud VARCHAR NOT NULL,

}


