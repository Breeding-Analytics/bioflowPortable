.libPaths("./R-Portable/R-4.4.1/library")
message('library paths:\n', paste('... ', .libPaths(), sep='', collapse='\n'))

update_cran_deps <- function() {
  lib <- .libPaths()[1]
  cran_pkgs <- c("xfun", "knitr", "rmarkdown")
  min_versions <- c(xfun = "0.62", knitr = "1.49", rmarkdown = "2.29")
  for (pkg in cran_pkgs) {
    installed_ver <- tryCatch(packageVersion(pkg), error = function(e) NULL)
    min_ver <- min_versions[pkg]
    needs_update <- is.null(installed_ver) ||
      (!is.null(min_ver) && installed_ver < package_version(min_ver))
    if (needs_update) {
      message("Updating ", pkg, " (installed: ",
              if (is.null(installed_ver)) "none" else as.character(installed_ver),
              ", need >= ", min_ver, ")")
      tryCatch(
        install.packages(pkg, lib = lib, repos = "https://cloud.r-project.org",
                         quiet = TRUE),
        error = function(e) message("Could not update ", pkg, ": ", conditionMessage(e))
      )
    } else {
      message(pkg, " is up to date (", as.character(installed_ver), ")")
    }
  }
}
			  
			  
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

update_cran_deps()
update_github()
bioflow::run_app()
