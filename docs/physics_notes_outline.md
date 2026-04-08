# Physics Notes Outline — MHD_BoundaryCompression

This outline defines the first physics-document set for the repository. Each note should be physics-first, should define all variables and symbols explicitly, and should include a table of notation.

---

## 1. module1_ideal_mhd_compression_problem.tex

### Purpose
Define the governing equations and explain the physical meaning of boundary-driven compression in a fixed Eulerian domain.

### Contents
- what ideal MHD means
- state variables and conserved variables
- governing equations in conservative form
- equation of state
- magnetic pressure and magnetic tension during compression
- meaning of flux freezing in ideal MHD
- what inward compression means on a fixed grid
- why density and magnetic field can both intensify during compression
- notation table

---

## 2. module2_boundary_driven_compression_physics.tex

### Purpose
Explain how an externally imposed inward boundary drive launches compressive disturbances into a magnetized plasma.

### Contents
- physical picture of inward boundary forcing
- difference between weak compression waves and strong shocks
- role of wave propagation speed
- interaction of waves arriving from multiple sides
- stagnation and central compression
- symmetry versus asymmetry in boundary forcing
- possible causes of nonuniform compression
- importance of temporal pulse shape
- notation table

---

## 3. module3_boundary_drive_models.tex

### Purpose
Define the drive-model family concept and explain the baseline and future drive types.

### Contents
- why a drive abstraction is needed
- prescribed inward boundary velocity
- pressure loading concept
- moving-wall concept
- pulse train concept
- asymmetric timing concept
- spatially varying drive concept
- relation between physical drive prescription and numerical boundary condition
- notation table

---

## 4. module4_uniformity_metrics_and_objectives.tex

### Purpose
Define what “uniform compression” means mathematically and physically.

### Contents
- core-region averaging
- density compression ratio
- magnetic-field compression ratio
- pressure compression ratio
- coefficient-of-variation type uniformity measures
- symmetry metrics
- residual velocity metrics
- composite objective function ideas
- how to compare competing drive prescriptions fairly
- notation table

---

## 5. module5_baseline_case_definition.tex

### Purpose
Document the first baseline case in full.

### Contents
- domain geometry
- initial density, pressure, and magnetic field
- chosen adiabatic index
- boundary sides and imposed inward velocity directions
- temporal pulse shape
- spatial drive profile
- expected qualitative evolution
- what diagnostics should be plotted first
- notation table

---

## 6. Suggested derivation notes

### conservative_ideal_mhd_equations.tex
Derivation and interpretation of conservative-form ideal MHD.

### boundary_velocity_prescription.tex
How a prescribed inward normal velocity is translated into a boundary condition.

### compression_ratio_metrics.tex
Derivation and interpretation of scalar compression measures.

### magnetic_flux_compression_measures.tex
How magnetic-field amplification should be interpreted during compression.

---

## 7. Suggested implementation notes

### run_order_and_workflow.tex
Explain what to run, in what order, and why.

### boundary_drive_interface.tex
Explain the `driveModel` structure and `evaluate_drive(...)` interface.

### ghost_cell_strategy.tex
Explain how boundary ghost cells are filled for the first drive model.

### diagnostics_pipeline.tex
Explain how raw fields become scalar metrics and comparison tables.
