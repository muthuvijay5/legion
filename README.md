# Legion - Build for PSG 🎓🏫

Flutter App for Students, Faculties, Club Members / Staffs to make their workspace more productive. These features are available in following views:
- Student View
- Faculty View
- Staff View

## Demo Videos 📹

Link : [Google Drive Folder](https://drive.google.com/drive/folders/1iAWppZGFHz00XPf0G2HUqLPiW0KY3530?usp=share_link)

## Views 👀

### Home View Functionality 🏡

- This page has options for opening account for various roles (ie. Student, Faculty, Staff)
- Head Admin validates the application
- In addition to this email verification has also been implemented.

### Students View Functionality ✅

Students have following interfaces:
- Profile View / Edit
- See all current events from various clubs and associations(Common as well as department and year specific)
- Can view all circulars from faculties
- Can apply to join recruitment of various clubs and associations (Common as well as department and year specific)

### Faculty View Functionality ✅

- Profile View / Edit
- Announcement (Circular) posting
- Delete an Announcement

### Staff View Functionality ✅

- Profile View / Edit
- Host an new Event
- Delete (Cancel) an Event
- Start Club Recruitment
- Close a Recruitment
- View all Recruitment Applications

### Problems faced currently 🥲

- Images are getting delayed when fetched over web
- █ Invalid Unicode / 文字 Chinese characters are displayed instead of Flutter Icons (Internal error in Flutter)
- Default android back is not supported, as there is internal occuring with Navigator

  1. Overview
The ELIZA AI Support Agent is designed to act as an intelligent support assistant for the team by answering queries related to:

Team documentation

Application architecture

Production troubleshooting

Codebase understanding

Database insights

The agent leverages multiple data sources and functions to provide accurate and contextual responses.

Key Capabilities
The ELIZA agent integrates with the following knowledge sources:

Confluence Documentation (Knowledge Base)

GitLab Codebase

Database Schema and Records

By combining these sources, the agent can provide a comprehensive response to user queries.

2. System Architecture
The ELIZA support agent works through modular functions connected to different data sources.

User Query
     ↓
ELIZA Agent
     ↓
------------------------------------------------
| Confluence KB | GitLab Codebase | Database |
------------------------------------------------
     ↓
Context Retrieval + Reasoning
     ↓
Generated Response
Each module is responsible for retrieving contextual information from a specific source.

3. Confluence Knowledge Base Integration
Objective
Allow the ELIZA agent to answer queries based on existing team documentation stored in Confluence.

Approach
Two approaches can be used to expose Confluence knowledge to the ELIZA agent:

Approach 1: Upload Confluence Documentation
Relevant Confluence pages can be exported and uploaded directly into the ELIZA agent knowledge base.

Steps
Identify relevant Confluence pages

Export documentation

Upload content to the ELIZA knowledge repository

Index documents for semantic search

Advantages
Simple implementation

Faster setup

Good for static documentation

Limitations
Manual updates required when documentation changes

Approach 2: Create a Nugget to Access Confluence
A Nugget can be created to dynamically fetch documentation from Confluence.

Process
ELIZA agent receives query

Nugget calls Confluence API

Relevant pages are retrieved

Content is processed and returned to the agent

Agent generates contextual answer

Advantages
Always uses latest documentation

No manual document uploads required

Scalable for large documentation sets

Example Use Cases
Application architecture queries

Deployment process

Runbooks

Troubleshooting guides

4. GitLab Codebase Integration
Objective
Allow the ELIZA agent to analyze the application codebase to:

Understand architecture

Explain code functionality

Help identify root causes of production issues

Approach 1: Upload Codebase Snapshot
A snapshot of the codebase can be uploaded to the ELIZA knowledge repository.

Steps
Export project repository

Upload source code

Index the code

Enable semantic search on code

Advantages
Simple implementation

Fast responses

Limitations
Code updates require re-upload

Approach 2: Dynamic Code Retrieval from GitLab
The agent dynamically fetches code using GitLab APIs.

Workflow
User Query
   ↓
ELIZA Agent
   ↓
GitLab Nugget/API
   ↓
Retrieve relevant files
   ↓
Agent analyzes code
   ↓
Response generated
Capabilities
The agent can:

Identify root causes of production issues

Explain code logic

Provide architecture insights

Trace code dependencies

Analyze logs and error traces

Example Queries
"Why is the payment API failing in production?"

"Where is the authentication logic implemented?"

"Explain the architecture of the notification service."

5. Database Integration
Objective
Enable the ELIZA agent to query database records dynamically and answer data-related questions.

Data Preparation
Before enabling DB querying, the following metadata must be provided to the agent:

Table schemas

Column definitions

Data types

Constraints

Relationships (foreign keys)

Sample records

This information helps the agent understand the structure of the database.

Query Generation Process
User Query
    ↓
ELIZA Agent
    ↓
Schema Understanding
    ↓
Generate SQL Query
    ↓
Execute Query
    ↓
Process Results
    ↓
Return Answer
Capabilities
The agent can:

Generate dynamic SQL queries

Perform joins across multiple tables

Retrieve relevant records

Summarize data results
