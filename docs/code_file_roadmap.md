# Code and File Roadmap — MHD_BoundaryCompression

This document explains the role of the main files and folders in the project. It is intended to serve as the first file-map document for the repository.

---

## 1. Top-level scripts

### `main_baseline_symmetric_compression.m`
Primary entry point for the first full forward run.

Responsibilities:
- load the baseline case definition
- build configuration structures
- build the grid
- initialize the plasma state
- build the selected drive model
- run the forward solver
- compute diagnostics
- generate plots and outputs

### `main_drive_parameter_sweep.m`
Batch driver for varying parameters within a single drive family.

Responsibilities:
- define a set of drive parameters to vary
- run multiple cases automatically
- collect scalar objective values
- produce comparison tables and plots

### `main_compare_drive_models.m`
Comparison driver across different drive families.

Responsibilities:
- instantiate multiple drive models
- run a common comparison scenario
- evaluate objective functions consistently
- summarize strengths and weaknesses of each drive family

---

## 2. Case files

### `cases/case_baseline_symmetric.m`
First baseline case.

Contains:
- domain size
- grid resolution
- physical constants
- initial state values
- selected drive type
- boundary-side activity
- drive amplitude and pulse parameters
- solver settings
- output settings

### `cases/case_baseline_xonly.m`
A simpler comparison case where only left and right boundaries are driven.

Purpose:
- isolate one-direction compression behavior
- test boundary logic with fewer active sides

### Template cases
These are placeholders for future families:
- asymmetric timing
- pulse trains
- spatially varying drive patterns

---

## 3. Source-code folders

## `src/config/`
Stores default parameter builders and configuration assembly.

Suggested files:
- `build_case_config.m`
- `default_physics_params.m`
- `default_numerics_params.m`
- `default_output_params.m`

Purpose:
centralize parameter handling so that case files remain readable.

---

## `src/grid/`
Stores grid generation and boundary indexing logic.

Suggested files:
- `build_grid.m`
- `build_boundary_index_sets.m`

Purpose:
provide geometry information to the solver and boundary routines.

---

## `src/state/`
Stores state initialization and variable conversions.

Suggested files:
- `initialize_uniform_state.m`
- `primitive_to_conservative.m`
- `conservative_to_primitive.m`
- `apply_state_floors.m`

Purpose:
ensure clean and consistent handling of the MHD state vector.

---

## `src/physics/`
Stores local physics helper functions.

Suggested files:
- `compute_pressure.m`
- `compute_sound_speed.m`
- `compute_alfven_speed.m`
- `compute_fast_speed.m`
- `compute_total_energy.m`

Purpose:
provide reusable physics calculations needed by the solver and diagnostics.

---

## `src/solver/`
Stores the core forward numerical method.

Suggested files:
- `advance_mhd_rk2.m`
- `compute_dt_cfl.m`
- `reconstruct_plm.m`
- `hll_flux_x.m`
- `hll_flux_y.m`
- `update_conservative_state.m`
- `compute_rhs_mhd.m`
- `apply_boundary_conditions.m`

Purpose:
perform the conservative MHD time integration.

---

## `src/boundary/`
Stores numerical boundary-condition implementation.

Suggested files:
- `apply_ghost_cells.m`
- `fill_boundary_from_drive_model.m`
- `impose_velocity_boundary.m`
- `impose_pressure_boundary.m`
- `impose_symmetry_boundary.m`
- `handle_boundary_corners.m`

Purpose:
translate drive instructions into actual numerical boundary states.

---

## `src/drive_models/`
Stores the physical drive family definitions.

Suggested files:
- `build_drive_model.m`
- `evaluate_drive.m`
- `drive_prescribed_inward_velocity.m`
- `drive_pressure_loading_template.m`
- `drive_moving_wall_template.m`

Subfolders:
- `temporal_profiles/`
- `spatial_profiles/`

Purpose:
separate the physical drive prescription from the numerical solver.

---

## `src/diagnostics/`
Stores scalar and field diagnostic calculations.

Suggested files:
- `compute_global_integrals.m`
- `compute_compression_metrics.m`
- `compute_uniformity_metrics.m`
- `compute_symmetry_metrics.m`
- `compute_divB_metrics.m`
- `compute_shock_indicators.m`
- `assemble_objective_function.m`

Purpose:
quantify the quality of compression in a way that supports later comparison and optimization.

---

## `src/analysis/`
Stores run-summary and ranking logic.

Suggested files:
- `summarize_run.m`
- `rank_parameter_sweep.m`
- `export_run_tables.m`

Purpose:
turn raw diagnostics into decision-ready summaries.

---

## `src/plotting/`
Stores plotting functions.

Suggested files:
- `plot_state_2d.m`
- `plot_linecuts.m`
- `plot_time_history.m`
- `plot_compression_metrics.m`
- `plot_boundary_drive_profile.m`

Purpose:
keep visualization code separate from solver code.

---

## `src/utils/`
General helper functions.

Suggested files:
- `ensure_output_dirs.m`
- `make_output_name.m`
- `validate_config.m`

Purpose:
reduce repeated boilerplate.

---

## 4. Documentation folders

## `docs/project_overview/`
High-level project description and file map.

## `docs/physics_notes/`
Physics-first explanations of the equations, compression physics, and diagnostic definitions.

## `docs/derivations/`
Step-by-step derivation notes.

## `docs/implementation_notes/`
Developer-facing notes about solver logic, boundary handling, and workflow.

## `docs/interview_notes/`
Optional concise summaries for explaining the project to others.

---

## 5. Test files

### `test_uniform_state_preservation.m`
Checks that a zero-drive uniform state remains uniform.

### `test_boundary_drive_zero_amplitude.m`
Checks that a drive object with zero amplitude does not alter the state.

### `test_symmetric_drive_symmetry_preservation.m`
Checks that the symmetric baseline case preserves symmetry to tolerance.

### `test_positive_pressure_density.m`
Checks that floors prevent nonphysical negative states.

### `test_drive_interface_outputs.m`
Checks that `evaluate_drive(...)` returns valid, consistent fields.

### `test_objective_function_sanity.m`
Checks that better compression is rewarded and higher nonuniformity is penalized.

### `test_divB_monitoring.m`
Checks that the divergence diagnostic pipeline behaves sensibly.

---

## 6. Recommended first build order

1. Write case and config builders.
2. Write grid builder and boundary indexing.
3. Write primitive/conservative state functions.
4. Write `driveModel` builder and `evaluate_drive(...)`.
5. Write boundary imposition layer for prescribed normal velocity.
6. Write the first solver stepper.
7. Write first diagnostics.
8. Run the baseline symmetric case.
9. Add plots and test coverage.

---

## 7. Most important architectural rule

The solver core should evolve the MHD equations and ask the boundary layer for numerical boundary states. The boundary layer should ask the drive model what physical drive is intended. This layering should remain intact even as more advanced drive families are added later.
