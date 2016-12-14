module TestBioArgParse

using Base.Test, BioArgParse, ArgParse, Bio: Seq

@testset "Parsing sequences" begin

    s = ArgParseSettings()
    s.add_help = true

    @add_arg_table s begin
        "--dna1", "-d"
            help = "A DNA Sequence"
            required = false
            arg_type = BioSequence{DNAAlphabet{4}}
            nargs = 1
        "--dna2", "-D"
            help = "A DNA Sequence, stored in 2bit"
            required = false
            arg_type = BioSequence{DNAAlphabet{2}}
            nargs = 1
    end

    runtest(args) = parse_args(args, s)

    @test runtest([]) == Dict{AbstractString, Any}(dna1=>nothing, dna2=>nothing)
    @test runtest(["--dna1",
                   "atcgatcg",
                   "--dna2",
                   "aaatttcccggg"]) == Dict{AbstractString, Any}(dna1=>BioSequence{DNAAlphabet{4}}("atcgatcg"),
                                                                 dna2=>BioSequence{DNAAlphabet{2}}("aaatttcccggg"))


end

end
