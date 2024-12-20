library(tidyverse)
library(glue)
library(stringr)
library(forcats)
# Part 3
library(tidygraph)
library(ggraph)
library(tidytext)
setwd("~/GIT/mee.git/mee.git")
repo_url<-"git@github.com:qiaohj/bs.diet.git"
clone_dir<-strsplit(repo_url, "/")[[1]]
clone_dir<-clone_dir[length(clone_dir)]
clone_dir<-gsub("\\.git", "", clone_dir)
clone_dir<-file.path(sprintf("%s/../repository/%s", getwd(), clone_dir))
clone_cmd <- glue("git clone {repo_url} {clone_dir}")
system(clone_cmd)

log_format_options <- c(datetime = "%ad", commit = "%h", parents = "%p", 
                        author = "%an", subject = "%s")
option_delim <- "\t"

log_format_str <- paste(log_format_options, collapse = option_delim)


log_format   <- glue("{log_format_str}")
log_options  <- glue('--pretty=format:"{log_format}" --date=format:"%Y-%m-%d %H:%M:%S"')
log_cmd      <- glue('git -C {clone_dir} log {log_options}')
log_cmd
system(glue('{log_cmd} -3'))
history_logs <- system(log_cmd, intern = TRUE) %>% 
  str_split_fixed(option_delim, length(log_format_options)) %>% 
  as_tibble() %>% 
  setNames(names(log_format_options))


