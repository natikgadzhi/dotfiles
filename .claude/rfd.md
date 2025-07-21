# Create new RFD instructions

## Usage
This instruction file is for creating new Request For Development documents, RFD for short.

```
/rfd {name} {main-goal}
```

## Steps to Create a New RFD

### Where to put the new RFD file

- Most projects have an `rfd` directory or an `agent/rfd` directory. If that directory exists, you're going to put the resulting rfd file in that directory. If not, create the directory.
- RFD file names follow the following pattern: `{date|YYYY-MM-DD}-{name}.md`

## RFD Concept

- RFD contains a set of requirements, goals, non-goals, and all of the constraints that describe a unit of work. That can be a new feature or a bug fix, etc.
- You (Claude or another agent) will work on the RFD implementation, and humans will review.
- When asked for estimates and plans, do not generate human estimates (weeks, etc) — assume you will work on this.

## Required Sections

- When a user asks you to make an RFD, you should ask questions to progressively shape the RFD and add more and more constraints until you are confident you can make a strong plan, and you removed all ambiguity in your approach.
- You should save the RFD file after each turn of questions and answers with the user to progressively improve the RFD
- RFD must include the following sections: name, summary, goals, non-goals, requirements (can contain scenarios or behaviors), constraints (what to do and not to do, like what libraries not to use, etc).
- RFD must include a TODO section that describes specific todos and a step by step plan for you to implement, and for the humans to review and deploy the code changes.
- When user provides the name and summary, take the time to research the existing project thoroughly and make a mental map of the existing applications, it's features and behaviors, and the way it is implemented and deployed.
- It's possible that the user will refer to satellite codebases. Usually any interdependent codebases will be in adjacent directories. Ask the user for clarification.

## General approach to RFDs
- Thoroughly research the existing projects and it's features and behaviors first.
- Generally, do not add new libraries / dependencies unless the user asked you to. If you cannot implement a feature without bringing a library, or it would be unreasonable to do so, ask the user first.
- Always suggest adding unit and integration tests in your plans.
- Always write that the agent MUST run and pass the tests to say that something is done. Tell the agent to never skip tests if "the failing test is unrelated".
- Tell the agent to keep changes minimal and related to the RFD they are working on.
- Tell the agent to only work on one todo at a time, and commit changes when user reviews them.
