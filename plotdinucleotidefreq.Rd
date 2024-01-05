\name{calcdinuclfreq}
\alias{calcdinuclfreq}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Calculate dinucleotide frequency in a GRanges object}
\description{
Given a reference genome as a BSgenome object and some ranges on that
reference, this function will return a vector of the same length as the
granges object, with percent of nucleotides.
}
\usage{
calcdinuclfreq(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{query}{A GenomicRanges or GenomicRangesList object with query regions.}
}

\value{ A numeric vector or list of vectors with the dinucleotide frequency for all 16 dinucleotides within the range of the query regions.}

\examples{


query = system.file("extdata", "vistaEnhancers.bed.gz", package="GenomicDistributions")
GRquery = Biostrings::dinucleotideFrequency(query)
ref = 'hg19'
dinuclfreq = calcdinuclfreq(query, ref)


calcdinuclfreq = function(query, ref) {
    .validateInputs(list(query=c("GRanges","GRangesList"),
                         ref="BSgenome"))
    if (is(query, "GRangesList")) {
        # Recurse over each GRanges object
        x = lapply(query, calcdinuclfreq, ref)
        return(x)
    }
    v = IRanges::Views(ref, query)
    # DN = dinucleotide
    dnvec = apply(Biostrings::dinucleotideFrequency(v))
    return(dnvec)

# plot dinucleotide frequency

plotdinuclcontent = function(dnvec) {
    .validateInputs(list(dnvec=c("numeric","list")))
    gcdf = lapply(dnvec, as.data.frame)
    # reshape2 is deprecated, but there's no other way to do this easily...
    gcdfReshaped = reshape2::melt(gcdf, id.vars=NULL)
    colnames(gcdfReshaped)[colnames(gcdfReshaped) == "L1"] = "regionSet"
    # plot multiple regionsets if dnvec is a list
    if (is(dnvec, "list")) {
        meansdf = aggregate(gcdfReshaped$value, list(gcdfReshaped$regionSet), mean)
        g = ggplot2::ggplot(gcdfReshaped, aes(x=value, colour=regionSet)) +
        geom_density() +
        geom_vline(data=meansdf, aes(xintercept=x, colour=Group.1),
                   linetype="dashed", size=0.5) +
        theme_classic() +
        theme(legend.position = "bottom")
    } else {
        # plot a single regionset
        g = ggplot2::ggplot(gcdfReshaped, aes(x=value)) + 
        geom_density() + 
        geom_vline(aes(xintercept=mean(value)),
                   color="red", linetype="dashed", size=0.5) + 
        theme_classic()
    }    
    g = g + 
        ggtitle("DN content distribution") + 
        theme(plot.title = element_text(hjust=0.5)) +
        xlab("DN %") + 
        xlim(0,1) 
    return(g)
}

