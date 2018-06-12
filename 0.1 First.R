
.First = function ()
{
  #This function will run when you start the project and is useful for install packages that are necessary
  
  # Load user specific things and sources function
  cat("\n\n---------------------------------------------------------------------------------------------------------------------\n")
  cat("--------------------------------------------------------------------------------------------------------------------- \n\n")
  
  cat("Loading packages and sourcing files for IF-Model Stedin; on failure please reload packages\n
      Modify .Rprofile to change these settings\n\n")
  
  # Install required packages if not installed already
  library(utils)
  packages = c("data.table", "plyr","sf","stringr","maptools","jsonlite","xlsx","RMySQL","logging")
  
  cat("Setting java heap memory to 32 gb \n")
  options( java.parameters = "-Xmx32g" )
  
  for (m in 1:length(packages)){
    # Install if not present
    if ((packages[m] %in% rownames(installed.packages()))==FALSE){
      cat("Package: ",packages[m]," not present, installing now. \n")
      install.packages(packages[m])
    }
  }
  
  # require packages
  for (m in 1:length(packages)){
    #cat("Loading package: ",packages[m],"\n")
    suppressMessages(library(packages[m],character.only=TRUE))
  }
  
  # Source some functions --------------------------------
  #sourcefiles = list.files()[grep("*.R$",list.files(),ignore.case=T)]
  sourcefiles = list.files(pattern = "[.]R$", recursive = TRUE)
  
  #exclude frontend/main
  sourcefiles = sourcefiles[!grepl("",sourcefiles)]
  
  #sourcefiles = sourcefiles[!(grepl('5.',sourcefiles))]
  cat("\nSourcing files: \n")
  l_ply(sourcefiles,function(x) {cat(x,"\n"); try(source(x))})


  # Finished -------------------------------------
  cat("\n\n---------------------------------------------------------------------------------------------------------------------\n")
  cat("\n\n---------------------------------------------------------------------------------------------------------------------\n")
  
  cat("Set up by T Bijl \n")
  cat("\n\n---------------------------------------------------------------------------------------------------------------------\n")
  cat("--------------------------------------------------------------------------------------------------------------------- \n\n")
  }
