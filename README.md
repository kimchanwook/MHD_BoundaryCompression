# MHD_BoundaryCompression

## Project summary

`MHD_BoundaryCompression` is a standalone MATLAB project for studying **boundary-driven compression in two-dimensional ideal magnetohydrodynamics (MHD)**. The physical question is:

> What external boundary-drive configuration produces the most spatially uniform compression of both the plasma fluid and the magnetic field inside a two-dimensional MHD domain?

The first forward model uses a **prescribed inward boundary velocity on a fixed Eulerian grid**. This is intentionally chosen as the simplest boundary-drive model that still captures the central compression physics. The code architecture is designed so that future drive models can be inserted later without restructuring the solver.

Examples of future drive types include:
- pressure loading
- moving-wall boundaries
- pulse trains
- asymmetric side timing
- spatially varying boundary forcing
- other shock or compression prescriptions

This project follows the same general style and documentation philosophy as `MHD_PINN_proj1`, but it is a **new standalone repository**, not an extension of that codebase.

---

## Scientific goal

A two-dimensional plasma is initialized in a fixed rectangular domain. An externally imposed inward drive at the boundaries launches compressive disturbances into the plasma. These waves can steepen, interact, and potentially produce a highly compressed central region.

The main objective is to determine which drive configuration gives the best combination of:
- strong plasma compression
- strong magnetic-field compression
- good spatial uniformity
- good symmetry
- low residual flow in the compressed region

This project starts with the **forward physics model first**. Optimization, surrogate modeling, and Physics-Informed Neural Network (PINN) ideas may be added later, but they are not part of the initial build.

---

## Baseline physical model

### Domain
A fixed two-dimensional Eulerian domain

\[
\Omega = [0,L_x] \times [0,L_y]
\]

with a structured finite-volume grid.

### Plasma model
The baseline plasma model is **ideal MHD** with conservative evolution of:
- mass density \(\rho\)
- momentum density \(\rho \mathbf{v}\)
- total energy density \(E\)
- magnetic field \(\mathbf{B}\)

subject to the magnetic divergence constraint

\[
\nabla \cdot \mathbf{B} = 0.
\]

### First drive model
The first boundary-drive model is:
- prescribed inward **normal velocity** at the boundaries
- smooth pulse in time
- uniform spatial profile along each driven wall for the baseline case

This drive model is easy to implement and also easy to generalize.

---

## Baseline case

The first recommended baseline case is a **symmetric four-sided inward compression** problem.

### Initial state
- uniform density \(\rho_0\)
- uniform pressure \(p_0\)
- zero initial velocity
- uniform magnetic field, for example \(\mathbf{B}_0 = (B_0,0,0)\)

### Boundary drive
All four boundaries apply the same inward normal velocity magnitude using a smooth temporal pulse.

A simple form is

\[
v_n(s,t) = -A \, f_t(t) \, f_s(s),
\]

where:
- \(A\) is the drive amplitude
- \(f_t(t)\) is the temporal pulse shape
- \(f_s(s)\) is the spatial boundary profile
- \(s\) is the coordinate along the boundary

For the first baseline:
- same amplitude on all sides
- same timing on all sides
- \(f_s(s)=1\)
- smooth pulse in time, such as a sine-squared envelope

---

## Project philosophy

This project is built around five principles:

1. **Physics-first**
   The solver architecture should reflect the physics question clearly.

2. **Modularity**
   Drive physics, boundary-condition implementation, diagnostics, and numerics should be separated.

3. **Explicit notation and definitions**
   All acronyms, variables, and symbols should be defined clearly in documentation.

4. **Forward model before optimization**
   The project begins with a trusted forward ideal-MHD compression solver.

5. **Future extensibility**
   The code should be ready for future drive-model replacement, parameter sweeps, objective-based ranking, and later optimization workflows.

---

## Module roadmap

### Module 0. Project overview and workflow map
Define the scientific question, repository structure, development order, and run order.

### Module 1. Governing equations and compression problem definition
Define ideal MHD, the meaning of boundary-driven compression, and the assumptions used in the baseline model.

### Module 2. Core 2D ideal MHD solver
Implement the finite-volume forward solver, conservative update, time stepping, reconstruction, and positivity protection.

### Module 3. Boundary-drive abstraction layer
Define a drive-model interface so that the solver can use multiple drive types through a common API.

### Module 4. Boundary-condition implementation layer
Translate the drive prescription into actual boundary ghost-cell or numerical boundary states.

### Module 5. Compression diagnostics and objective functions
Define quantitative measures of fluid compression, magnetic-field compression, uniformity, symmetry, and stagnation quality.

### Module 6. Baseline symmetric compression case
Run the first clean reference problem using symmetric inward velocity drive.

### Module 7. Drive-family parameter studies
Explore the effect of amplitude, rise time, pulse width, spatial pattern, timing offset, and repetition.

### Module 8. Additional drive models
Add pressure loading, moving walls, pulse trains, asymmetric drives, and other forcing patterns.

### Module 9. Optimization-ready workflow
Standardize parameter vectors, objective wrappers, and batch runs for future search and surrogate workflows.

---

## Proposed repository structure

```text
MHD_BoundaryCompression/
│
├── README.md
├── project_plan.md
├── main_baseline_symmetric_compression.m
├── main_drive_parameter_sweep.m
├── main_compare_drive_models.m
│
├── cases/
│   ├── case_baseline_symmetric.m
│   ├── case_baseline_xonly.m
│   ├── case_asymmetric_timing_template.m
│   ├── case_pulse_train_template.m
│   └── case_spatial_pattern_template.m
│
├── src/
│   ├── config/
│   ├── grid/
│   ├── state/
│   ├── physics/
│   ├── solver/
│   ├── boundary/
│   ├── drive_models/
│   ├── diagnostics/
│   ├── analysis/
│   ├── plotting/
│   └── utils/
│
├── docs/
│   ├── project_overview/
│   ├── physics_notes/
│   ├── derivations/
│   ├── implementation_notes/
│   └── interview_notes/
│
├── tests/
│   ├── test_uniform_state_preservation.m
│   ├── test_boundary_drive_zero_amplitude.m
│   ├── test_symmetric_drive_symmetry_preservation.m
│   ├── test_positive_pressure_density.m
│   ├── test_drive_interface_outputs.m
│   ├── test_objective_function_sanity.m
│   └── test_divB_monitoring.m
│
└── outputs/
    ├── figures/
    ├── data/
    └── logs/
```

---

## What belongs where

### `cases/`
Case-definition files live here.
Each case should specify:
- domain and grid size
- physical parameters
- initial state
- chosen drive model
- drive parameters
- solver settings
- output settings

A case file should define a problem setup, not solver logic.

### `src/`
Reusable implementation code lives here.
This includes:
- numerics
- flux calculations
- time stepping
- boundary handling
- drive-model evaluation
- diagnostics
- plotting helpers

### `docs/`
This directory stores project memory and physics explanation.
It should include:
- governing equations
- derivations
- implementation notes
- file map
- workflow notes
- diagnostic definitions

### `tests/`
This directory stores correctness checks.
Tests should verify things such as:
- zero-drive preservation of a uniform state
- valid drive-interface outputs
- symmetry preservation under symmetric forcing
- positivity of density and pressure
- basic divergence-control diagnostics

---

## Boundary-drive abstraction

The solver should not hard-code a specific drive type. Instead, a `driveModel` object or struct should define the physical drive through a common interface.

Suggested evaluation call:

```matlab
bcData = evaluate_drive(driveModel, boundaryInfo, t, grid, stateInterior);
```

### Inputs
- `driveModel`: selected drive specification
- `boundaryInfo`: side identity, local coordinates, normals, and index sets
- `t`: current simulation time
- `grid`: grid and geometry information
- `stateInterior`: nearby interior state values

### Output
A boundary-condition data structure describing what should be imposed numerically.

For example:

```matlab
bcData.mode   = 'prescribed_normal_velocity';
bcData.active = true;
bcData.vn     = ...;
bcData.vt     = ...;
bcData.p      = [];
bcData.Bn     = [];
bcData.Bt     = [];
```

This lets the solver remain agnostic to whether the physical drive is:
- prescribed velocity
- pressure loading
- moving-wall motion
- asymmetric timing
- pulse train forcing

---

## First diagnostics to compute

The first diagnostic layer should include:

### Fluid compression
A core-region density compression metric, for example

\[
C_\rho(t) = \frac{\langle \rho(t) \rangle_{\text{core}}}{\langle \rho(0) \rangle_{\text{core}}}.
\]

### Magnetic compression
A magnetic-field compression measure, for example

\[
C_B(t) = \frac{\langle |\mathbf{B}|(t) \rangle_{\text{core}}}{\langle |\mathbf{B}|(0) \rangle_{\text{core}}}.
\]

### Uniformity
For a generic quantity \(q\), define a normalized spatial variation

\[
U_q(t) = \frac{\sqrt{\langle (q-\langle q\rangle)^2 \rangle_{\text{core}}}}{\langle q \rangle_{\text{core}}}.
\]

Use this for:
- density
- pressure
- magnetic-field magnitude

### Symmetry
For symmetric baseline cases, compute left-right and top-bottom mismatch measures.

### Residual core flow
A good compressed core should not only be dense and magnetically compressed; it should also have small residual velocity after stagnation.

---

## Suggested development order

1. Create the repository structure and planning documents.
2. Define the state vector and ideal MHD variable conversions.
3. Implement grid generation and boundary index sets.
4. Build the baseline finite-volume solver core.
5. Add the boundary-drive abstraction.
6. Implement the first prescribed-velocity drive model.
7. Implement the baseline symmetric case.
8. Add compression diagnostics and summary plots.
9. Add verification and sanity tests.
10. Extend to additional drive families.

---

## Initial file roadmap

### Top-level driver scripts
- `main_baseline_symmetric_compression.m`  
  Runs the first symmetric inward-drive baseline case.

- `main_drive_parameter_sweep.m`  
  Runs a sweep over drive amplitude, pulse width, or timing.

- `main_compare_drive_models.m`  
  Compares multiple drive families using a common objective framework.

### First case files
- `case_baseline_symmetric.m`  
  Uniform initial state, four-sided symmetric inward drive.

- `case_baseline_xonly.m`  
  Compression applied only from left and right boundaries.

### First implementation notes to write later
- run order and workflow
- ghost-cell strategy
- drive interface details
- objective-function definitions

---

## Immediate next implementation target

The first coding milestone should be:

> Build the repository skeleton, define the baseline case file, define the `driveModel` interface, and implement the minimum grid/state/config infrastructure needed for the first forward solver pass.

That keeps the project grounded in the forward physics model and preserves the same staged, modular development style as your earlier MHD work.
