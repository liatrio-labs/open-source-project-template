# Specifications Directory

This directory contains specifications for this repository, managed using the **Liatrio Spec-Driven Development (SDD)** workflow.

## About Spec-Driven Development

Spec-Driven Development is a systematic approach to software development that emphasizes:

- **Clear Requirements**: Specifications define what needs to be built before implementation begins
- **Structured Planning**: Tasks are generated from specifications to create actionable implementation plans
- **Verifiable Implementation**: Proof artifacts validate that specifications are correctly implemented
- **Documentation**: Specifications serve as living documentation of project decisions and requirements

## Workflow Phases

The SDD workflow consists of four main phases:

### 1. Spec Creation

Create a specification document that defines:

- Goals and objectives
- User stories
- Functional requirements
- Demo criteria
- Success metrics

Specifications are stored in this directory with the naming convention: `[NN]-spec-[feature-name]/[NN]-spec-[feature-name].md`

### 2. Task Generation

From the specification, generate a structured task list that breaks down the work into:

- Parent tasks (major units of work)
- Sub-tasks (specific implementation steps)
- Demo criteria for each task
- Proof artifact requirements

Task lists are stored alongside specifications: `[NN]-spec-[feature-name]/[NN]-tasks-[feature-name].md`

### 3. Implementation

Execute the task list systematically:

- Complete sub-tasks within each parent task
- Create proof artifacts demonstrating completion
- Commit work at logical checkpoints (per parent task)
- Update task status as work progresses

### 4. Validation

Verify that the implementation meets all specification requirements:

- Review proof artifacts
- Verify demo criteria are met
- Confirm all requirements are satisfied
- Update specification status

## Directory Structure

```text
docs/specs/
├── README.md (this file)
├── [NN]-spec-[feature-name]/
│   ├── [NN]-spec-[feature-name].md
│   ├── [NN]-tasks-[feature-name].md
│   └── [NN]-proofs/
│       └── [NN]-task-[TT]-proofs.md
└── ...
```

Where:

- `[NN]` is a zero-padded 2-digit number (01, 02, 03, etc.)
- `[TT]` is the task number within the spec
- Each spec directory contains the specification, task list, and proof artifacts

## Example Specifications

This repository includes several example specifications:

- `00-spec-github-template-extraction/` - Template extraction workflow
- `01-spec-audit-fixes/` - Repository audit improvements
- `02-spec-repository-infrastructure-improvements/` - Infrastructure enhancements

These examples demonstrate the SDD workflow in practice.

## Learn More

For detailed documentation on the Spec-Driven Development workflow, including:

- Workflow commands and tools
- Best practices for writing specifications
- Task generation strategies
- Validation techniques

See the official SDD workflow repository:

**[https://github.com/liatrio-labs/spec-driven-workflow](https://github.com/liatrio-labs/spec-driven-workflow)**

## Getting Started

To create a new specification:

1. Create a new directory: `docs/specs/[NN]-spec-[feature-name]/`
2. Create the specification file: `[NN]-spec-[feature-name].md`
3. Follow the SDD workflow phases outlined above
4. Reference existing specifications for structure and format examples

For questions or assistance, refer to the SDD workflow repository or contact the Liatrio DevOps team.
