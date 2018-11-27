
# Neusomatic on Azure BatchAI
Neusomatic with Azure BatchAI

In this example 'preprocess.py' script is executed on prem, the data are transfered to the cloud with 'upload_data.sh', and the training phase is executed with Azure BatchAI.

Directory structure:
- dataout/models blob container contains the pretrained models
- file share data contains the input files for the training (artificial case)
- file share test contains the input files for the training (AJT case)

Job setup is described in 1stgpujob.json

Prior the training phase install_stable.sh script is executed on every node.
install.sh contains the possible optimizations.

## Setup variables
```
rgname = hpc-batchai
wsname = neusomatic_workspace
storaccname=neusomaticstorage
expname=pytorch_experiment
```

## Create BatchAI workspace
```
az group create -n $rgname -l westeurope
az batchai workspace create -g $rgname -n $wsname -l westeurope
```

## Create BatchAI experiment
```
az batchai experiment create -g $rgname -n $expname -l westeurope -
```

## Create a computing cluster
```
clustername=nc6
az batchai cluster create -n $clustername -g $rgname -w $wsname -s Standard_NC6 -t 2 --generate-ssh-keys
```

## Setup the storage account 
```
az storage account create -n $storaccname --sku Standard_LRS -g $rgname
az storage share create -n logs --account-name $storaccname
az storage share create -n scripts --account-name $storaccname
az storage share create -n data --account-name $storaccname
az storage share create -n test --account-name $storaccname
az storage directory create -n dataout -s data --account-name $storaccname
```

## Upload files 
```
az storage file upload -s scripts --source install.sh --path prep --account-name $storaccname
az storage file upload-batch -s /mnt/bigdata/output_dir/standalone/dataset --pattern */candidates*.tsv* --destination data --account-name $storaccname
```

## Create a job
```
jobname=n1
az batchai job create -c $clustername -n $jobname -g $rgname -w $wsname -e $expname -f 1stgpujob.json --storage-account-name $storaccname 
```

## Monitor the execution
```
az batchai job file stream -j $jobname -g $rgname -w $wsname -e $expname -f stdout-0.txt
```

## Job output
```
az batchai job show -n distributed_pytorch -g $rgname -w $wsname -e $expname --query jobOutputDirectoryPathSegment
```

## Download the job results
Results can be viewed with Azure Storage Explorer

## Delete the cluster
```
az batchai cluster delete -n $clustername -g $rgname -w $wsname
```

## More information
- [1] https://github.com/Azure/BatchAI/blob/master/recipes/PyTorch/PyTorch-GPU-Distributed-Gloo/cli-instructions.md
- [2] https://docs.microsoft.com/en-us/azure/batch-ai/
