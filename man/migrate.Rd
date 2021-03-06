% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/migration_api.R
\name{migrate}
\alias{migrate}
\alias{get_migratable}
\alias{publish}
\alias{toggle_migratable}
\title{Migrate Workflows}
\usage{
migrate(migration_directory = NULL, subscription = list(),
  form = NULL, gallery = get_gallery(),
  target_alteryx_api_key = getOption("target_alteryx_api_key"),
  target_alteryx_secret_key = getOption("target_alteryx_secret_key"),
  target_gallery = getOption("target_alteryx_gallery"), verbose = TRUE)

get_migratable(subscription = list(), gallery = get_gallery(),
  verbose = TRUE)

publish(app, migration_directory = NULL, form = NULL,
  target_alteryx_api_key = getOption("target_alteryx_api_key"),
  target_alteryx_secret_key = getOption("target_alteryx_secret_key"),
  target_gallery = getOption("target_alteryx_gallery"), verbose = TRUE)

toggle_migratable(app, gallery = get_gallery())
}
\arguments{
\item{migration_directory}{A directory for storing downloaded resources.
Defaults to a random temporary directory.}

\item{subscription}{A \code{list} of subscriptions ids to filter migratable
results by private studio}

\item{form}{A \code{list} that contains metadata for the published resource
in the target environment. If NULL, the defaults will be assumed from the
source environment. A \code{list} that contains \itemize{
  \item name
  \item owner
  \item validate
  \item isPublic
  \item sourceId
  \item workerTag
  \item canDownload
}}

\item{gallery}{URL for your Alteryx Gallery}

\item{target_alteryx_api_key}{Admin API key for target environment}

\item{target_alteryx_secret_key}{Admin API secret key for target environment}

\item{target_gallery}{URL for your target Alteryx Gallery}

\item{verbose}{Print information related to migration status}

\item{app}{A single \code{alteryx_app} returned from \code{get_app}}
}
\value{
NULL value. Use \code{verbose = TRUE} to see migration status.
}
\description{
The migration endpoints require access to the Gallery admin
API. Users cannot authorize using non-admin keys.

Migrating workflows is a four-step process:

\enumerate{
  \item Find all Gallery resources marked as "Ready to Migrate"
  \item Download the resources from the source environment
  \item Publish the resources to the target environment
  \item Toggle "Ready to Migrate" flag
}

The functions \code{get_migratable}, \code{publish}, and
\code{toggle_migratable} perform the above tasks individually:

\itemize{
  \item \code{get_migratable}: Returns a \code{list} of resources marked as
  ready for migration in Gallery
  \item \code{publish}: Downloads and publishes resources
  \item \code{toggle_migratable}: Toggles "Ready to Migrate" flag
}

The function \code{migrate} is provided as a wrapper to automate migration
from end-to-end.
}
\section{Additional Information}{

Remember to set your API key, secret, and Gallery location for the target
environment.

It is possible for deleted resources to show as marked for migration. In
this situation, you will see a message that the resource was "(Skipped due
to a problem)."

It is possible to migrate from and to the same environment.
}

\examples{
\dontrun{
# to run manually
app <- get_migratable()[[1]]
form <- list(
  name = "app_name.yxwz",
  owner = "new_owner_email@domain.com",
  validate = "false",
  isPublic = "false",
  sourceId = "ABC123",
  workerTag = "",
  canDownload = "false"
)

publish(
  app,
  migration_directory = "c:/aspot/tostage/files"
  form = form
)

toggle_migratable(app)

# automated
migrate(
  form = form,
  migration_directory = "c:/aspot/tostage/files"
)

}

}
