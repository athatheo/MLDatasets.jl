export KarateClub

"""
    Zachary's Karate Club

The Karate Club dataset originally appeared in Ref [1].

The network contains 34 nodes (members of the karate club).
The nodes are connected by 78 undirected and unweighted edges.
The edges indicate if the two members interacted outside the club.

The node labels indicate which community or the karate club the member belongs to.
The club based labels are as per the original dataset in Ref [1].
The community labels are obtained by modularity-based clustering following Ref [2].
The data is retrieved from Ref [3] and [4].
One node per unique label is used as training data.

# Interface

- [`KarateClub.edge_index`](@ref)
- [`KarateClub.labels`](@ref)

# References

[1]: [An Information Flow Model for Conflict and Fission in Small Groups](http://www1.ind.ku.dk/complexLearning/zachary1977.pdf)
[2]: [Semi-supervised Classification with Graph Convolutional Networks](https://arxiv.org/abs/1609.02907)
[3]: [PyTorch Geometric Karate Club Dataset](https://pytorch-geometric.readthedocs.io/en/latest/_modules/torch_geometric/datasets/karate.html#KarateClub)
[4]: [NetworkX Zachary's Karate Club Dataset](https://networkx.org/documentation/stable/_modules/networkx/generators/social.html#karate_club_graph)
"""
module KarateClub

"""
    edge_index()

Returns an adjacency list where the first and second vector
contain the source and target nodes of each edge respectively.

```julia-repl
using MLDatasets: KarateClub
adj = KarateClub.edge_index()
```
"""
function edge_index()::Vector{Vector{Int}}
    src = [
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2,
        2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5,
        6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 11, 11,
        11, 12, 13, 13, 14, 14, 14, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18,
        19, 19, 20, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 24, 24, 24, 25,
        25, 25, 26, 26, 26, 27, 27, 28, 28, 28, 28, 29, 29, 29, 30, 30, 30,
        30, 31, 31, 31, 31, 32, 32, 32, 32, 32, 32, 33, 33, 33, 33, 33, 33,
        33, 33, 33, 33, 33, 33, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34,
        34, 34, 34, 34, 34, 34
    ]
    target = [
        2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 18, 20, 22, 32, 1, 3, 4, 8,
        14, 18, 20, 22, 31, 1, 2, 4, 8, 9, 10, 14, 28, 29, 33, 1, 2, 3, 8,
        13, 14, 1, 7, 11, 1, 7, 11, 17, 1, 5, 6, 17, 1, 2, 3, 4, 1, 3, 31,
        33, 34, 3, 34, 1, 5, 6, 1, 1, 4, 1, 2, 3, 4, 34, 33, 34, 33, 34, 6,
        7, 1, 2, 33, 34, 1, 2, 34, 33, 34, 1, 2, 33, 34, 26, 28, 30, 33,
        34, 26, 28, 32, 24, 25, 32, 30, 34, 3, 24, 25, 34, 3, 32, 34, 24,
        27, 33, 34, 2, 9, 33, 34, 1, 25, 26, 29, 33, 34, 3, 9, 15, 16, 19,
        21, 23, 24, 30, 31, 32, 34, 9, 10, 14, 15, 16, 19, 20, 21, 23, 24,
        27, 28, 29, 30, 31, 32, 33
    ]

    adj = [src, target]
    return adj
end

"""
    labels(mode = :club)

Returns a vector containing the node labels indicating which club or community
the node belongs to.

The type of labels can be specifed using the `mode` variable which takes two values:
`:club` and `:community`.

```julia-repl
using MLDatasets: KarateClub

## Club labels
club_labels = KarateClub.labels(:club)

## Community labels
com_labels = KarateClub.labels(:community) 
```
"""
function labels(mode::Symbol = Symbol("club"))::Vector{Int}
    if mode == :club
        clubs = [
            1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        ]
        return clubs
    elseif mode == :community
        communities = [
                1, 1, 1, 1, 3, 3, 3, 1, 0, 1, 3, 1, 1, 1, 0, 0, 3, 1, 0, 1, 0, 1,
                0, 0, 2, 2, 0, 0, 2, 0, 0, 2, 0, 0
            ]
        return communities
    else
        ArgumentError("The valid label modes are `club` and `community`")
    end
end

end #module