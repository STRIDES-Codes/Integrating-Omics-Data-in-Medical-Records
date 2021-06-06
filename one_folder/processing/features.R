library(Rsubread)
args = commandArgs(trailingOnly = TRUE)
infile = args[1]
outfile =args[2]
ref = args[3]
mycounts<-featureCounts(infile, annot.ext=file.path(ref,"hg38.gff"), isGTFAnnotationFile=TRUE, isPairedEnd=TRUE)
count = as.data.frame(mycounts$count)
write.csv(count,file = outfile)
