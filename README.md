# NPRK-order-conditions
Codes for the paper: 

[1] B. K. Tran, B. S Southworth, T. Buvoli. **Order Conditions for Nonlinearly Partitioned Runge-Kutta Methods**. 2024. [arXiv:2401.12427](https://arxiv.org/abs/2401.12427).

### NPRK Trees

`NPRKTrees/NPRKTrees.jl`

 - Julia module which adds functionality for NPRK trees and order conditions to `RootedTrees.jl` ([repository](https://github.com/SciML/RootedTrees.jl)). Includes functions:
 - `ARKTreeIterator`: produces a `Vector` of `ColoredRootedTree`s containing all non-isomorphic ARK trees of a given number of vertex colorings and given order.
 - `NPRKTreeIterator`: produces a `Vector` of `ColoredRootedTree`s containing all non-isomorphic NPRK trees of a given number of edge colorings and given order. 
 - `isMultiColored`: determines whether a `ColoredRootedTree` (either ARK or NPRK tree specified as a Bool in argument) contains multiple colors, corresponding to coupling conditions.
 - `GetParentIndex`: given a node in a tree, returns the index in the level sequence of the parent node.
 - `isColorBranching`: determines whether an NPRK tree is color branching, i.e., contains at least one node with two outward edges of different colors, corresponding to nonlinear coupling conditions.
 - `elementaryWeightNPRK2`: given an NPRK tableau $A$ (cubic 3-tensor) and $b$ (square matrix) and an NPRK tree $\tau$ corresponding to 2 partitions (i.e., 2 colors), computes the elementary weight $\phi(\tau)$ of that tree, i.e., the LHS of the order condition (See Algorithm 1 of [1]). 
 - `residualNPRK2`: computes the residual of the order condition corresponding to the above elementary weight, i.e., $|\phi(\tau) - 1/\gamma(\tau)|$.
 - `NPRKTrees/nprktrees_test.jl`: tests to verify the above module.

### Symbolic order conditions

`symbolic_order_conditions/M_colored_rooted_trees.jl`
 - Generates the level sequence, color sequence and density of all (non-isomorphic) NPRK trees of a given number of partitions and order. Requires `RootedTrees.jl` ([repository](https://github.com/SciML/RootedTrees.jl)) and `DelimitedFiles`. Output is saved as a csv file.

`symbolic_order_conditions/M2_print_nprk_conditions.nb`

`symbolic_order_conditions/M3_print_nprk_conditions.nb`

 - Mathematica notebooks for producing symbolic NPRK order conditions for $M=2$ partitions and $M=3$ partitions, respectively, for any order of NPRK trees.
 - Reads in output files from `M_colored_rooted_trees.jl`.
 - Also includes Mathematica implementations of `isMultiColored`, `GetParentIndex`, `isColorBranching` above.
 - Folder includes several pre-generated output files.

### Embedded estimates of nonlinear coupling

 `embedded_estimate/embNPRKestimate.nb`
   
 - Mathematica notebook for the numerical example performed in [1], which shows how embedded NPRK methods can be used to measure nonlinear coupling strength. Considers specifically an embedded NPRK method generated from a Lobatto IIIA-IIIB pair applied to the Lotka-Volterra system. Includes:
 - Scale test for embedded estimate with respect to coupling parameter.
 - Scale test for embedded estimate with respect to timestep.
 - Convergence test to verify the correct nonlinear and additive order of the embedded method.
