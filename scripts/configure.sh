#!/bin/bash


#Select CPU- or GPU-based execution
if [ $1 = "gpu" ]; then
   export CUDA_VISIBLE_DEVICES=0
   echo "GPU based run"
else
   export CUDA_VISIBLE_DEVICES=
   echo "CPU based run"
fi

 
 


