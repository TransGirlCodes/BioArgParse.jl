module BioArgParse

using Bio: Seq
import ArgParse.parse_item

"Parse a string passed in on the command line into a biological sequence."
function parse_item{A<:Alphabet}(::Type{BioSequence{A}}, x::AbstractString)
    return BioSequence{A}(x)
end

"Parse a string passed in on the command line into a nucleotide."
function parse_item{N<:Nucleotide}(::Type{N}, x::AbstractString)
    return convert(N, x[1])
end

"Parse a string passed in on the command line into a vector of nucleotides."
function parse_item{N<:Nucleotide}(::Type{Vector{N}}, x::AbstractString)
    return [convert(N, char) for char in x]
end


end
