FROM jupyter/base-notebook:latest

# Switch to root to install additional packages
USER root

# Install any additional packages you need here, for example:
RUN apt-get update && apt-get install -y vim git && apt-get clean


# RUN pip install -r requirements.txt

# Switch back to jovyan to avoid running as root
USER jovyan
