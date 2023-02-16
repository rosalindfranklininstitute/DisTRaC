---
title: 'DisTRaC: Accelerating High Performance Compute Processing'
tags:
  - Distributed storage
  - High performance File storage
  - Object Storage
  - Intermediate data processing
  - RAM
  - High performance compute
authors:
  - name: Gabryel Mason-Williams
    orcid: 0000-0002-2981-3430
    corresponding: true
    affiliation: "1" # (Multiple affiliations must be quoted)
  - name: Laura Shemilt 
    affiliation: "1"
    orcid: 0000-0001-5199-5624
  - name: Joss Whittle 
    affiliation: "1"
    orcid: 0000-0002-4147-7185
  - name: Matt Williams
    orcid: 0000-0003-2198-1058
    affiliation: 4
  - name: Christopher Woods
    orcid: 0000-0001-6563-9903
    affiliation: 3
  - name: Mark Basham
    orcid: 0000-0002-8438-1415
    affiliation: "1, 2"
affiliations:
 - name: Rosalind Franklin Institute, Artificial Intelligence and Informatics, Didcot, Oxfordshire, UK
   index: 1
 - name: Diamond Light Source, Scientific Computing, SSCC, Didcot, Oxfordshire, UK 
   index: 2
 - name: University of Bristol, IT services, Bristol, Bristol City, UK
   index: 3
 - name: University of Bristol, Jean Golding Institute, 
   index: 4
date: 23 November 2022
bibliography: paper.bib
---

# Summary

\href{https://github.com/rosalindfranklininstitute/DisTRaC}{DisTRaC}  leverages the large amount of RAM available on high-performance computing (HPC) clusters to allow for a hyperconverged infrastructure as a service (HCIaaS) paradigm to operate in HPC, which can, in turn, remove the need for a central shared storage system. This is especially important for HPC clusters in the cloud, where creating high-performance file systems is considerably expensive to operate and run efficiently. DisTRaC removes this need via creating a distributed transient object/file store that lasts as long as a cluster/processing job requires while utilising the RAM of the compute nodes for storage.  

# Statement of need

High-performance computing (HPC) clusters are composed of four main components: the job scheduler, compute, networking and storage. These components all play a role in the performance of the system. DisTRaC is a Ceph deployment tool [@ceph] that allows for a high-performance job-specific distributed file/object store utilising the RAM of the compute node to be deployed within a job submission script in a scalable and time-efficient way. Thus DisTRaC can, in cases where the data could fit into the RAM of the compute nodes, remove the requirement of a high-performance file system entirely. DisTRaC is designed to be used in environments where the data generated or used for a compute job would comfortably fit within the RAM of the compute nodes used for the compute job.  

The advantages of DisTRaC are primarily due to the data and different applications that high-performance systems use, which means that the storage is often characterised by the requirement of expensive high-performance file systems that deal with large and small files Lustre [@lustre], GPFS [@gpfs]. Due to their inherent complexities, these systems are often costly and difficult to maintain. This issue is ever present in environments such as the cloud, where these options come at an additional cost to the compute resource [@pricing]. Furthermore, the cost is increased by the file system needing to persist after a job is finished or has crashed.

DisTRaC allows for a more secure separation of user data between jobs as the data is stored in isolated job persistent storage. Thus isolating the blast radius of potentially erroneous jobs only affects the compute nodes utilised within the job instead of the whole system via the central file system.

Due to the bandwidth of the RAM, DisTRaC is often limited by the node interconnect network rate and thus can run faster than a high-performance file system. For example, the tomography reconstruction program SAVU had the overall processing time reduced by 8.32% and the I/O overhead reduced by 81.04% compared to the central high-performance file system. [@DisTRaC]

All the above help reduce HPC cluster costs, especially in the cloud, when using tools such as \href{https://clusterinthecloud.org}{Cluster-in-the-Cloud (CitC)}\footnote{https://clusterinthecloud.org} or AWS ParallelCluster [@ParallelCluster] by reducing the need for file systems or reducing job time. In turn, it helps reduce the  $\mathrm{CO_2}$ emissions associated with HPC clusters due to the reduced resources required to run the cluster and improved compute utilisation, helping HPC facilities move towards Net-Zero.

# DisTRaC Workflow

A DisTRaC workflow, as demonstrated in  \autoref{fig:distrac},  differs from a traditional workflow, as seen in figure \autoref{fig:hpc}. In a traditional workflow, the storage cluster is predefined and globally accessable from all the compute nodes. However, this separation introduces a potential bottleneck for compute jobs due to the network rate from the compute cluster to the storage cluster and the competition for resources on the storage cluster, which can impact the performance of the compute jobs. In a DisTRaC workflow, the storage cluster and the compute cluster are hyper-converged within the scheduled compute job as specified by the user. Therefore, only the nodes within the compute job can access and interact with the storage cluster, thus isolating any potential damage to those nodes. In addition, the I/O of the storage cluster is now limited by the node interconnect network rate and has no external competition for resources. This can improve I/O-bound applications that require reading and writing to the storage cluster and compute-bound applications that read data from the storage cluster.


![Traditional HPC cluster workflow: The storage and compute clusters are separated and globally accessible from one another. The initial data is loaded into the globally accessible high performance storage cluster. The user then submits a compute job processing this data on the storage cluster. Once the compute job is finished, the processed data is outputted to a permanent storage location, i.e. a remote object store or the storage cluster. \label{fig:hpc}](./images/hpc.png){ width=100% }

![DisTRaC HPC cluster workflow: A user requests compute nodes for their job. A Ceph cluster is then deployed on top of these nodes utilising the RAM to create hyperconverged storage and compute nodes. The initial data is then loaded into the Ceph storage cluster, allowing for fast data processing. Once the data is processed, it is outputted to a permanent storage location, i.e. a remote object store or external filesystem. \label{fig:distrac}](./images/distrac.png){ width=100% }

# Scalable Deployment

When a Ceph instance is created, a set of keys for, Monitors (MON)s, Managers (MGR)s, Object Storage Devices (OSD)s, Clients, Meta Data Servers (MDS)s and Rados Gateways (RGW)s (if required) are made. In a traditional deployment, with tools such as Ansible, the system would SSH to the nodes copying the keys and files to start the relevant daemon and check the system's state. This step is unrequired in an HPC cluster where a Networked File System (NFS) is present, as nodes can already see the keys on the shared file system. Instead, the action of starting the relevant daemons on each node is needed. Thus DisTRaC takes full advantage of the homogeneous nature of HPC clusters and job scheduler to run the jobs in parallel using Message Passing Interface (MPI) [@walker1996mpi]. Taking full advantage of this means that DisTRaC efficiently deploys OSDs onto the appropriate nodes in parallel, bypassing the issue of sequential SSH deployment. Afterwards, an RGW or MDS on the node 0 or storage pool is created, finishing the deployment on the storage cluster. See \autoref{fig:distrac-deploy} for example deployment. 


![DisTRaC deployment - A MON is created on the head node first; then, the keys are put on the NFS. Putting the keys on NFS means the other nodes can see the keys. Then the MGR is created as required by Ceph Luminous version 12.*. MPI is then run across the specified nodes using the keys on NFS to create the subsequent OSDs in parallel. The final step creates a pool, an MDS or an RGW, depending on what the user specified. Mounting the filesystem across the nodes via MPI if requested. \label{fig:distrac-deploy}](./images/deploy.png){ width=100% }

The removal of Ceph using DisTRaC follows a similar vein as deployment, using MPI to remove Ceph daemons and processes, then removing the keys and files from NFS see \autoref{fig:distrac-remove}.

![DisTRaC removal - MPI is run across the nodes to remove Ceph's daemons and clears the Ceph system folders. Then the MPI is run to remove the OSDs, which removes the ceph volume groups, unmounts the OSDs from the system, clears the OSDs system files, and frees up the RAM used in the process. Finally, the keys are removed from NFS. \label{fig:distrac-remove}](./images/remove.png){ width=100% }

# Ongoing Research 

## Integration with Cluster-in-the-Cloud (CitC)

DisTRaC can be used on-premise or in cloud environments. However, due to the high-level privileges the user requires to deploy a Ceph storage cluster, DisTRaC is often run in the cloud. Therefore, DisTRaC has been integrated into Cluster-in-the-Cloud (CitC) to stay consistent with the open source and cost reduction aims.

# Acknowledgements

This work was carried out with the support of the Rosalind Franklin Insitute, Diamond Light Source, the Bristol BioDesign Institute and the University of Bristol. 

# References