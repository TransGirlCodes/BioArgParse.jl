module TestBioArgParse

using Base.Test, BioArgParse, ArgParse
using Bio: Seq

@testset "Parsing sequences" begin

    s = ArgParseSettings()
    s.add_help = true

    @add_arg_table s begin
        "--dna1", "-d"
            help = "A DNA Sequence"
            required = false
            arg_type = BioSequence{DNAAlphabet{4}}
        "--dna2", "-D"
            help = "A DNA Sequence, stored in 2-bit"
            required = false
            arg_type = BioSequence{DNAAlphabet{2}}
        "--rna1", "-r"
            help = "An RNA Sequence"
            required = false
            arg_type = BioSequence{RNAAlphabet{4}}
        "--rna2", "-R"
            help = "An RNA Sequence, stored in 2-bit"
            required = false
            arg_type = BioSequence{RNAAlphabet{2}}
        "--prot", "-P"
            help = "An amino acid sequence"
            required = false
            arg_type = BioSequence{AminoAcidAlphabet}
        "--nuc", "-n"
            help = "A DNA nucleotide"
            required = false
            arg_type = DNANucleotide
        "--rnuc", "-q"
            help = "An RNA nucleotide"
            required = false
            arg_type = RNANucleotide
    end

    runtest(args) = parse_args(args, s)

    @test runtest([]) == Dict{AbstractString, Any}("dna1"=>nothing,
                                                   "dna2"=>nothing,
                                                   "rna1"=>nothing,
                                                   "rna2"=>nothing,
                                                   "prot"=>nothing,
                                                   "nuc"=>nothing,
                                                   "rnuc"=>nothing)

    answer1 = Dict{AbstractString, Any}("dna1"=>BioSequence{DNAAlphabet{4}}("atcgatcg"),
                                        "dna2"=>BioSequence{DNAAlphabet{2}}("aaatttcccggg"),
                                        "rna1"=>BioSequence{RNAAlphabet{4}}("aucgaucg"),
                                        "rna2"=>BioSequence{RNAAlphabet{2}}("aaauuucccggg"),
                                        "prot"=>BioSequence{AminoAcidAlphabet}("andeqhm"),
                                        "nuc"=>DNA_A,
                                        "rnuc"=>RNA_U
                                       )
    @test runtest(["--dna1",
                   "atcgatcg",
                   "--dna2",
                   "aaatttcccggg",
                   "--rna1",
                   "aucgaucg",
                   "--rna2",
                   "aaauuucccggg",
                   "--prot",
                   "andeqhm",
                   "--nuc",
                   "A",
                   "--rnuc",
                   "U"]) == answer1

    @test runtest(["-d",
                   "atcgatcg",
                   "-D",
                   "aaatttcccggg",
                   "-r",
                   "aucgaucg",
                   "-R",
                   "aaauuucccggg",
                   "-P",
                   "andeqhm",
                   "-n",
                   "a",
                   "-q",
                   "u"]) == answer1


end

end
