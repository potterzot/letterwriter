#!/usr/bin/Rscript
# Generate a blank letter

#load the representative data
reps <- read.csv("contacts.csv", stringsAsFactors = FALSE) #rep data

# Get the CL arguments
script_args <- commandArgs(trailingOnly = TRUE)

if (length(script_args) == 0) stop("USAGE: 'gen_letter.R <name1> [additional names]'\n")
if (script_args[[1]] == "--help") { 
  print("USAGE: 'gen_letter.R <name1> [additional names]'")
  quit()
} else if (script_args[[1]] == "--list") print(reps$name)

#cycle through names to create letters
for (n in script_args) {
  if (n %in% reps$name) {
    rep <- subset(reps, name == n)
    command <- paste0("./gen_letter.sh ",
                     "--title '", rep$title, 
                     "' --name '", rep$name, 
                     "' --address1 '", rep$address1,
                     "' --address2 '", rep$address2,
                     "' --city '", rep$city,
                     "' --state '", rep$state,
                     "' --zip '", rep$zip,
                     "'"
                     )
  } else {
    command <- paste("./gen_letter.sh",
                     "--name", n 
                     )
  }
  system(command)
}




