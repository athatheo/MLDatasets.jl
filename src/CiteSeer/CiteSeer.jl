export CiteSeer


"""
    CiteSeer

The CiteSeer citation network dataset from Ref. [1].
Nodes represent documents and edges represent citation links.
The dataset is designed for the node classification task. 
The task is to predict the category of certain paper.
The dataset is retrieved from Ref. [2].

# Interface

- [`CiteSeer.dataset`](@ref)

# References

[1]: [Deep Gaussian Embedding of Graphs: Unsupervised Inductive Learning via Ranking](https://arxiv.org/abs/1707.03815)
[2]: [Planetoid](https://github.com/kimiyoung/planetoid)
"""
module CiteSeer

using DataDeps
using ..MLDatasets: datafile, read_planetoid_data
using DelimitedFiles: readdlm

const DEPNAME = "CiteSeer"
const LINK = "https://github.com/kimiyoung/planetoid/raw/master/data"
const DOCS = "https://github.com/kimiyoung/planetoid"
const DATA = "ind.citeseer." .* ["x", "y", "tx", "allx", "ty", "ally", "graph", "test.index"]

function __init__()
    register(DataDep(
        DEPNAME,
        """
        Dataset: The $DEPNAME dataset.
        Website: $DOCS
        """,
        map(x -> "$LINK/$x", DATA),
        "7f7ec4df97215c573eee316de35754d89382011dfd9fb2b954a4a491057e3eb3",  # if checksum omitted, will be generated by DataDeps
        # post_fetch_method = unpack
    ))
end

"""
    dataset(; dir=nothing, reverse_edges=true)

Retrieve the CiteSeer dataset. The output is a named tuple with fields
```julia-repl
julia> keys(CiteSeer.dataset())
(:node_features, :node_labels, :adjacency_list, :train_indices, :val_indices, :test_indices, :num_classes, :num_nodes, :num_edges, :directed)
```

In particular, `adjacency_list` is a vector of vector, 
where `adjacency_list[i]` will contain the neighbors of node `i`
through outgoing edges.

If `reverse_edges=true`, the graph will contain
the reverse of each edge and the graph will be undirected.

See also [`CiteSeer`](@ref).

# Usage Examples

```julia
using MLDatasets: CiteSeer
data = CiteSeer.dataset()
train_labels = data.node_labels[data.train_indices]
```
"""
dataset(; dir=nothing, reverse_edges=true) = 
    read_planetoid_data(DEPNAME, dir=dir, reverse_edges=reverse_edges)


end #module 

