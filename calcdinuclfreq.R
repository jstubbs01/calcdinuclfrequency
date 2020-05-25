### I used roxygen2 to generate this template. I tried to keep it similar to the style of the other .Rd files listed 
### in GenomicDistributions/man/.


# \name{calcdinuclfreq}
# \alias{calcdinuclfreq}

# \title{Calculate dinucleotide frequency in a GRanges object}
# \description{
#  Given a reference genome as a BSgenome object and a GRanges, this function will return a list or numeric vector with with percent of Cs and Gs.
 #}
# \usage{
  #calcdinuclfreq(x)
#}
#%- maybe also 'usage' for other objects documented here.
#\arguments{
 # \item{query}{A GenomicRanges or GenomicRangesList object with query regions.}
#}

#\value{ A numeric vector or list of vectors with the dinucleotide frequency for all 16 dinucleotides within the range of the query regions.}

#\examples{
  
  
 # query = system.file("extdata", "vistaEnhancers.bed.gz", package="GenomicDistributions")
  #GRquery = Biostrings::dinucleotideFrequency(query)
  #ref = 'hg19'
  #dinuclfreq = calcdinuclfreq(query, ref)
  
  
  calcdinuclfreq = function(query, ref) {
    
    # here I used the same function structure from calcGCcontent
    # query and ref as input, gvec as output
    
    
    .validateInputs(list(query=c("GRanges","GRangesList"),
                         ref="BSgenome"))
    
    # I believe this function validates the input as GRanges
    
    if (is(query, "GRangesList")) {
      # Recurse over each GRanges object
      x = lapply(query, calcdinuclfreq, ref)
      return(x)
    }
    
    # This returns a list of the inputs with lapply
    
    v = IRanges::Views(ref, query)
    
    # The Views virtual class is a general container for storing a set of views 
    # on an arbitrary Vector object, called the "subject"
    # The subject in this case are inputs
    
    gcvec = apply(Biostrings::dinucleotideFrequency(v))
    
    # I swapped out alphabetfrequency function for dinucleotideFrequency
    
    return(gcvec)