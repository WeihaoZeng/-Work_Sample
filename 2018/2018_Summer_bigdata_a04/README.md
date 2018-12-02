# Assignment - Machine Learning with SparkML

**You should thoroughly read through the entire assignment before beginning your work! Don't start the cluster until you are ready. Pay careful attention, there are changes to the instance sizes, software versions, and port numbers.**

## Cluster Setup

Create an AWS EMR cluster with *Advanced Options* and the following configuration:

* Select `emr-5.16.0` from the drop-down
* Click check-boxes for these applications only: Hadoop 2.8.4, Tez 0.8.4, Hive 2.3.3, Spark 2.3.1	
* Click Next
* Edit the instance types and set 1 master and 5 core of m5.4xlarge **(these are significantly larger instances than used in the past and a newer generation)** 
* Click Next
* Give the cluster a name, and you can uncheck logging, debugging and termination protection enabled
* Click Next
* Select your key-pair
* Click "Create Cluster"

Once the cluster is in "Waiting" mode (should only take a few minutes), ssh into the master with agent forwarding:

```
ssh-add
ssh -A hadoop@...
```

Run the following commands **in order**, making sure to edit the repository name changing [[your-github-name]]:

```
sudo yum install -y git
git clone git@github.com:gwu-bigdata/summer2018-a04-[[your-github-name]].git
cd summer2018-a04-[[your-github-name]].git
bash post-startup-ipython-jupyter-py2-setup.sh 
```

Once this is done, please type `exit` to logoff from the master node (make sure you do this) and then log back on, making sure you enable both ssh-agent forwarding and port forwarding:

```
ssh-add
ssh -A -L8888:localhost:8888 hadoop@...
``` 

You can then open a browser and navigate to http://localhost:8888 to see your Jupyter Notebook environment, which got started within the assignment directory. 

### Provide the Master Node and Cluster Metadata

Provide the instance metadata just as you did for Assignment A1. Run this command in the master node.

```
curl http://169.254.169.254/latest/dynamic/instance-identity/document/ > instance-metadata.json
```

## Problem

You will perform the work for this problem within the [problem-1.ipynb](problem-1.ipynb) Jupyter notebook.

After you finish working on the problem, you will commit the Jupyter notebook `.ipynb` file called `problem-1.ipynb.`

## Submitting the Assignment

Make sure you commit **only the files requested**, and push your repository to GitHub!

The files to be committed and pushed to the repository for this assignment are:

* `instance-metadata.json`
* `problem-1.ipynb`


## Grading Rubric 

* We will look at the results files and the scripts. If the result files are exactly what is expected, in the proper format, etc., we may run your scripts to make sure they produce the output. If everything works, you will get full credit for the problem.
* If the results files are not what is expected, or the scripts produce something different from what is expected, we will look at code and provide partial credit where possible and applicable.
* Points will be deducted for each the following reasons:
	* Instructions are not followed
	* Output is not in expected format (not sorted, missing fields, wrong delimeter, unusual characters in the files)
	* There are more files in your repository than need to be 
	* There are additional lines in the results files (whether empty or not)
	* Files in repository are not the requested filename


	
