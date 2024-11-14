.libPaths("./R-Portable/R-4.4.1/library")
message('library paths:\n', paste('... ', .libPaths(), sep='', collapse='\n'))

library(devtools)
update_github <- function() {
  pkgs = c("cgiarBase","cgiarPipeline","cgiarOcs","bioflow")
  print(pkgs)
  desc <- lapply(pkgs, packageDescription, lib.loc = NULL)
  for (d in desc) {
    message("working on ", d$Package)
    if (!is.null(d$GithubSHA1)) {
      message("Github found")
      checkInt=curl::has_internet()
	   if(checkInt==TRUE){install_github(repo = paste0(d$GithubUsername, "/", d$GithubRepo))}
      install_github(repo = paste0(d$GithubUsername, "/", d$GithubRepo))
    }
  }
}
update_github()
bioflow::run_app()
