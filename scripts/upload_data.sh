#!/bin/bash
storaccname=yourstoragename
workdir=/mnt/bigdata/output_dir/AJT_test

#Upload preprocessing data to Azure Storage
az storage file upload-batch -s $workdir/dataset --pattern */*.vcf* --destination test --account-name $storaccname
az storage file upload-batch -s $workdir/dataset --pattern */*.bed* --destination test --account-name $storaccname
az storage file upload-batch -s $workdir/dataset --pattern */candidates*.tsv* --destination test --account-name $storaccname

