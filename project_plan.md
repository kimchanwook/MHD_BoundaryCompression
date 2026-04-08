# Project Plan — MHD_BoundaryCompression

## 1. Project title

**MHD_BoundaryCompression**

Boundary-driven compression in two-dimensional ideal magnetohydrodynamics.

---

## 2. Core scientific question

The project studies a two-dimensional magnetized plasma inside a fixed computational domain whose outer boundaries are driven inward by an externally prescribed compression drive.

The central question is:

> What boundary-drive configuration produces the most spatially uniform compression of both the plasma fluid and the magnetic field?

The external drive may vary in:
- timing
- pulse shape
- amplitude
- spatial pattern along a boundary
- side-to-side symmetry
- repetition frequency
- choice of drive physics

The initial implementation uses the simplest drive type:

**prescribed inward boundary velocity on a fixed Eulerian grid**

The project architecture must nevertheless allow later replacement with more advanced drive families without requiring major restructuring.

---

## 3. Project philosophy

This repository should follow the same broad organizational style and documentation philosophy as `MHD_PINN_proj1`, while remaining a fully separate standalone project.

The guiding principles are:

1. **Forward physics first**  
   Build the ideal-MHD compression solver first.

2. **Clear modular layering**  
   Separate solver numerics, drive physics, boundary imposition, diagnostics, and case setup.

3. **Physics-first documentation**  
   The physics meaning of each module should be explicit.

4. **Explicit notation**  
   All variables, symbols, and acronyms should be defined clearly.

5. **Future extensibility**  
   The repository should be ready for future parameter studies, optimization, surrogate modeling, and PINN-related ideas, but should not begin there.

---

## 4. Physics problem definition

### 4.1 Domain
The baseline computational domain is a two-dimensional rectangle

\[
\Omega = [0,L_x] \times [0,L_y].
\]

The grid is Eulerian and fixed in space.

### 4.2 Plasma model
The plasma is modeled as an **ideal magnetohydrodynamic fluid**, with conservative evolution of:
- mass density \(\rho\)
- momentum density \(\rho \mathbf{v}\)
- total energy density \(E\)
- magnetic field \(\mathbf{B}\)

The equation of state is that of an ideal gas,

\[
p = (\gamma - 1)\left(E - \frac{1}{2}\rho |\mathbf{v}|^2 - \frac{1}{2\mu_0}|\mathbf{B}|^2\right).
\]

### 4.3 Boundary-driven compression
External forcing is imposed at the outer boundary to push the plasma inward. The boundary drive launches compressive disturbances into the domain. These disturbances may interact and form a compressed region in the interior.

The scientific target is not merely to achieve high compression, but to achieve:
- strong density increase
- strong magnetic-field amplification
- spatially uniform interior compression
- good symmetry
- low residual core flow after convergence or stagnation

---

## 5. Development roadmap

## Module 0. Project overview and workflow
Define the scientific goal, module order, file map, and run order.

**Deliverables**
- `README.md`
- `project_plan.md`
- file roadmap
- workflow notes

---

## Module 1. Governing equations and assumptions
Document the ideal MHD equations, the meaning of compression in a fixed Eulerian frame, and all baseline assumptions.

**Questions to answer**
- What variables are evolved?
- What equation of state is used?
- What does inward compression mean on a fixed grid?
- What role does magnetic flux compression play?

**Deliverables**
- governing-equation notes
- symbol tables
- baseline problem statement

---

## Module 2. Core two-dimensional ideal MHD solver
Implement the forward numerical solver.

**Numerical ingredients**
- finite-volume discretization
- conservative update
- slope reconstruction
- approximate Riemann solver
- explicit time stepping
- positivity floors
- divergence monitoring or cleaning

**Deliverables**
- state update engine
- time-step selection
- flux functions
- primitive/conservative conversions

---

## Module 3. Boundary-drive abstraction layer
Create an interface that lets the solver query a drive model without hard-coding a particular drive type.

**Target capability**
The solver should be able to ask:
- which boundaries are active?
- what physical quantity is prescribed?
- what value or profile is imposed at this time and location?

**Deliverables**
- `driveModel` design
- `evaluate_drive(...)` API
- prescribed-velocity drive implementation
- template stubs for future drive models

---

## Module 4. Boundary-condition implementation layer
Translate drive prescriptions into numerical boundary states.

**Examples**
- ghost-cell filling
- normal-velocity enforcement
- tangential treatment
- magnetic-field handling at boundaries
- corner consistency rules

**Deliverables**
- boundary-condition routines
- boundary ghost-cell strategy note
- basic corner handling

---

## Module 5. Compression diagnostics and objective functions
Create diagnostic measures that quantify compression quality.

**Required diagnostic categories**
- fluid compression strength
- magnetic compression strength
- spatial uniformity
- symmetry
- residual core motion
- divergence diagnostics

**Deliverables**
- diagnostic functions
- run summary metrics
- objective-function assembly logic

---

## Module 6. Baseline symmetric compression case
Run the first clean reference problem.

**Recommended baseline**
- square domain
- uniform initial density and pressure
- zero initial velocity
- uniform magnetic field
- same inward velocity pulse on all four sides
- smooth pulse in time
- uniform spatial drive along each wall

**Purpose**
- exercise the full solver chain
- provide the first compression movie and diagnostics
- create a standard comparison case for later studies

---

## Module 7. Parameter studies for the first drive family
Vary the prescribed-velocity drive parameters.

**Parameters to sweep**
- drive amplitude
- rise time
- pulse width
- start time offset by wall
- spatial tapering
- single pulse versus pulse train

**Deliverables**
- sweep scripts
- ranking tables
- comparison plots

---

## Module 8. Additional drive families
Add more advanced forcing models without changing the solver core.

**Future drive families**
- pressure loading
- moving-wall boundaries
- pulse trains
- asymmetric wall timing
- spatially varying drive patterns
- other shock prescriptions

---

## Module 9. Optimization-ready workflow
Prepare the repository for future search and control studies.

**Not for the first stage**, but plan for:
- standardized drive parameter vectors
- objective wrapper functions
- batch run utilities
- exportable run summaries
- later surrogate and PINN integration

---

## 6. Boundary-drive abstraction design

This is the main architectural requirement of the project.

### 6.1 Design rule
The solver must not directly encode a specific drive family. Instead, the drive must be supplied through a common abstraction.

### 6.2 Recommended interface

```matlab
bcData = evaluate_drive(driveModel, boundaryInfo, t, grid, stateInterior);
```

### 6.3 Inputs
- `driveModel`: drive type and parameters
- `boundaryInfo`: side identity, normals, boundary coordinates, index sets
- `t`: simulation time
- `grid`: geometry and metric information
- `stateInterior`: nearby interior state

### 6.4 Output
A boundary-condition data structure, for example:

```matlab
bcData.mode   = 'prescribed_normal_velocity';
bcData.active = true;
bcData.vn     = ...;
bcData.vt     = ...;
bcData.p      = [];
bcData.Bn     = [];
bcData.Bt     = [];
```

### 6.5 Why this matters
This abstraction separates:
- the **physical intent of the drive**
from
- the **numerical way the boundary is imposed**

That separation is what will make future drive-model replacement easy.

---

## 7. First drive model

The first implemented drive family should be:

### Prescribed inward boundary velocity

For each driven boundary,

\[
v_n(s,t) = -A \, f_t(t) \, f_s(s),
\]

where:
- \(v_n\) is inward normal velocity
- \(A\) is drive amplitude
- \(f_t(t)\) is temporal pulse shape
- \(f_s(s)\) is spatial boundary profile
- \(s\) is the coordinate along the boundary

### First baseline choices
- same amplitude on all sides
- same pulse timing on all sides
- spatially uniform profile: \(f_s(s)=1\)
- smooth temporal pulse, such as sine-squared or Gaussian-like

This is the easiest forward model that still captures the problem structure clearly.

---

## 8. First baseline case

### Case name
`case_baseline_symmetric`

### Initial condition
- \(\rho = \rho_0\)
- \(p = p_0\)
- \(\mathbf{v} = 0\)
- \(\mathbf{B} = (B_0,0,0)\) or another simple uniform field choice

### Boundary forcing
- left wall drives to the right
- right wall drives to the left
- bottom wall drives upward
- top wall drives downward
- all with equal magnitude and identical pulse shape

### Recommended amplitude regime
Begin with mild or moderate compression rather than immediately strong shocks. A useful choice is a boundary-speed amplitude that is a small fraction of the initial fast magnetosonic speed.

### Purpose of the baseline case
- verify symmetry handling
- verify boundary-condition logic
- produce the first diagnostic time histories
- establish a clean reference against which future drive models can be compared

---

## 9. Uniform-compression diagnostics

The project should define compression quality quantitatively.

### 9.1 Fluid compression metric

\[
C_\rho(t) = \frac{\langle \rho(t) \rangle_{\text{core}}}{\langle \rho(0) \rangle_{\text{core}}}
\]

### 9.2 Magnetic compression metric

\[
C_B(t) = \frac{\langle |\mathbf{B}|(t) \rangle_{\text{core}}}{\langle |\mathbf{B}|(0) \rangle_{\text{core}}}
\]

### 9.3 Uniformity metric
For any scalar field \(q\),

\[
U_q(t) = \frac{\sqrt{\langle (q-\langle q\rangle)^2 \rangle_{\text{core}}}}{\langle q \rangle_{\text{core}}}
\]

Suggested choices:
- \(q=\rho\)
- \(q=p\)
- \(q=|\mathbf{B}|\)

### 9.4 Symmetry metric
Compare left-right and top-bottom reflected states.

### 9.5 Residual flow metric
Measure interior velocity magnitude after compression. A good compressed core should not remain strongly sheared or streaming.

### 9.6 Composite objective function
Later, runs can be ranked using a weighted objective that rewards strong compression and penalizes nonuniformity, asymmetry, and residual motion.

---

## 10. Folder and file responsibilities

### `cases/`
Case definitions and scenario setup files.

### `src/`
All reusable code modules.

### `docs/`
Physics notes, derivations, workflow notes, and file maps.

### `tests/`
Correctness and consistency checks.

---

## 11. Initial documentation package

The initial planning-document package should contain:
- `README.md`
- `project_plan.md`
- physics-notes outline
- code/file roadmap

Recommended first documentation files under `docs/` later:
- `project_overview/project_overview.tex`
- `physics_notes/module1_ideal_mhd_compression_problem.tex`
- `physics_notes/module2_boundary_driven_compression_physics.tex`
- `physics_notes/module3_boundary_drive_models.tex`
- `physics_notes/module4_uniformity_metrics_and_objectives.tex`
- `physics_notes/module5_baseline_case_definition.tex`
- `implementation_notes/run_order_and_workflow.tex`
- `implementation_notes/boundary_drive_interface.tex`

---

## 12. Immediate next coding step

The next implementation step after planning should be:

1. create the repository folder skeleton
2. create the first case definition file
3. define the `driveModel` struct and evaluation API
4. define default config files
5. define grid and state initialization functions

Only after those are in place should the solver update functions be written.
