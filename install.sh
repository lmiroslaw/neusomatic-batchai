apt-get --assume-yes install yum 

## Prepare pre-requisite packages
yum install -y git gcc g++ gcc-c++ zlib zlib-devel docker wget
yum update -y nss curl libcurl
 
## Get conda
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O ~/miniconda.sh
chmod +x miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda

export PATH="$HOME/miniconda/bin:$PATH"

#GPU-based execution
CUDA_VISIBLE_DEVICES=0

#CPU-based execution
#CUDA_VISIBLE_DEVICES=

#echo "export PATH=\"$HOME/miniconda/bin:$PATH\" >> ~/.bashrc"
source ~/.bashrc
 
## Install python packages using conda
conda install zlib=1.2.11 numpy=1.14.3 scipy=1.1.0 -y
conda install pytorch=0.3.1 torchvision=0.2.0 cuda80=1.0 -c pytorch -y
conda install cmake=3.12.1 -c conda-forge -y
conda install pysam=0.14.1 pybedtools=0.7.10 pytabix=0.0.2 samtools=1.7 tabix=0.2.5 bedtools=2.27.1 biopython=1.68 -c bioconda -y
 
## Install GCC/G++ version 7 
yum install -y centos-release-scl 
yum install -y devtoolset-7-gcc* 
scl enable devtoolset-7 bash 
#which gcc 
#gcc --version
 
## Download neusomatic and build the tool
cd $AZ_BATCHAI_JOB_TEMP_DIR
git clone https://github.com/bioinform/neusomatic.git
cd neusomatic
./build.sh
 
 


