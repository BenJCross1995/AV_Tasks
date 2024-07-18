# PAN - 21 AV LambdaG

#----INSTALL IDIOLECT PACKAGE----#
# devtools::install_github("https://github.com/andreanini/idiolect")

#----LOAD LIBRARIES----#
suppressPackageStartupMessages({
  library(idiolect)
})


# Helper Functions
read_jsonl <- function(file_loc){
  # Read each line as seperate object
  lines <- readLines(file_loc)
  # Convert to list as we read from json
  lines <- lapply(lines, jsonlite::fromJSON)
  # Unlist the object
  lines <- lapply(lines, unlist)
  # Bind rows to create a dataframe
  lines <- dplyr::bind_rows(lines)
  
  return(lines)
}

#----SET FILE LOCATIONS----#
known_loc <- "/Users/user/Documents/datasets/pan_21/pan21-authorship-verification-test/pan21-known.jsonl"
unknown_loc <- "/Users/user/Documents/datasets/pan_21/pan21-authorship-verification-test/pan21-unknown.jsonl"

#----LOAD FILES----#
x <- read_jsonl(known_loc)
y <- read_jsonl(unknown_loc)

#----CONVERT TO CORPUS----#]

# Convert the x and y dataframes to a corpus object
x_corp <- quanteda::corpus(x)
y_corp <- quanteda::corpus(y)

#----POSNoise----#

x_pos <- idiolect::contentmask(x_corp, algorithm = "POSnoise", output = "sentences")
y_pos <- idiolect::contentmask(y_corp, algorithm = "POSnoise", output = "sentences")