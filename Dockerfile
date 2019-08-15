# based on rocker/geospatial image
FROM rocker/geospatial:latest

# install R packages & hugo with user `rstudio`
#RUN su - rstudio -c "R -e \"install.packages(c('dlnm','gnm','mvmeta','caTools',\
#  'shinyjs','tmap','car','forestplot','tsModel','lcmm','mapproj','blogdown'));\
#  blogdown::install_hugo(force=TRUE)\""
RUN R -e "install.packages(c('dlnm','gnm','mvmeta','caTools','gridExtra','ggpubr',\
  'shinyjs','car','forestplot','tsModel','lcmm','mapproj','blogdown'));\
  options(blogdown.hugo.dir='/usr/bin/');blogdown::install_hugo(force=TRUE)"
#RUN chmod o+rx /usr/bin/hugo

# OPTIONAL
# set umask for multi-user group sharing
RUN echo '# Setting umask\n\
    umask 007' >> /etc/profile &&\
    echo "# Setting umask\n\
    umask 007" >> /root/.bashrc &&\
    echo '# Setting umask\n\
    Sys.umask("007")' >> usr/local/lib/R/etc/Rprofile.site

# OPTIONAL
# change docker/rocker r-repos from MRO to CRAN
#RUN sed -i 's/options(repos = c(CRAN=/#options(repos = c(CRAN=/' usr/local/lib/R/etc/Rprofile.site

# OPTIONAL
# mainly changed `default_sweave_engine` to `knitr` and `default_latex_program` to `XeLaTeX`
# `user-setting` get from already configed rstudio docker by runnig `cp ~/.rstudio/monitored/user-settings <mount path>/user-settings -r` in Rstudio terminal
# put it in the same directory with dockerfile
# copy user-settings profile into docker image
#COPY user-settings ./home/rstudio/.rstudio/monitored/user-settings

# OPTIONAL
# config git
#RUN su - rstudio -c "git config --global user.email <email>"
#RUN su - rstudio -c "git config --global user.name <user name>"