library(Rsubread)
args = commandArgs(trailingOnly = TRUE)
infile1 = args[1]
infile2 = args[2]
outfile = args[3]
ref = args [4]
align(index=file.path(ref,'hg38'), readfile1=infile, readfile2=infile2, output_file=outfile, output_format="SAM")