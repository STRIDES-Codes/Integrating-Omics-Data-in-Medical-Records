library (seqTools)
args = commandArgs(trailingOnly = TRUE)
infile = args[1]
outfile = args[2]
trimFastq(infile, outfile = outfile, qualTrimLeft=20,qualTrimRight=20, minSeqLen=100)