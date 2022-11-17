## Setup
* deepmd-kit
````bash
conda install deepmd-kit=*=*cpu lammps-dp=*=*cpu -c deepmodeling
````
 
* dpdata
```bash
pip install dpdata
````
## initiate data
```python
from dpdata import LabeledSystem,System,Multisystem
from glob import glob

ls_md=LabeledSystem('./aimd_gaussian_CH4_output',fmt='gaussian/md')
ls_str=LabeledSystem('./aimd_CH4_output',fmt='gaussian/log')
## multisystem easy way
struct=glob('./g16/*.log')
mstruct=Multisystem()
for s in mstruct:
    try:
        ls=LabelSystem(s)
    except:
        print(s)
    if len(ls)>0:
        mstruct.append(ls)
        
## dump data to deepmd
ms.to_deepmd_raw('deepmd')
ms.to_deepmd_npy('deepmd')

## dump data to other format
ms.to('lammps/lmp','conf.lmp',frame_idx=[:])

### perturb
perturbed_system = dpdata.System('./xxx.log').perturb(pert_num=3, 
    cell_pert_fraction=0.05, 
    atom_pert_distance=0.6, 
    atom_pert_style='normal')
print(perturbed_system)
print(perturbed_system.data)
```

### Train a model

### Frozen a model

### Run lammps
