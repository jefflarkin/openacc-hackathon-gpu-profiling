OpenACC Hackathon - GPU Profiling Examples
==========================================
High-Level Timers on Cray XK7
-----------------------------
To gather high-level information about how your program is using the GPU, `nvprof` 
print just the time spent in the kernels and data transfers. To use this command, 
do the following.

    $ export PMI_NO_FORK=1
    $ module load cudatoolkit # If not already loaded
    $ aprun -b nvprof ./a.out input # The executable must be in lustre.
    
Gathering Profile Data on a Cray XK7
------------------------------------
Two scripts have been provided in the `scripts` directory to simplify gathering
GPU profile data on the XK7. It is generally best to visualize this data on
your local machine using the NVIDIA CUDA Visual Profiler, which comes with the
CUDA Toolkit. You do not need to have a CUDA-enabled GPU to use the Visual
Profiler, but you will have to download the CUDA Toolkit in order to get it.

### Gathering a Timeline ###
The `nvprof_timeline.sh` script can be used to gather a GPU timeline of your
application. Because of the way that Cray's aprun command launches executables
you must set the `PMI_NO_FORK` environment variable to `1` in your run script.
Then simply add `nvprof_timeline.sh` to your run command immediately before the
executable. This will give 1 timeline file for each node of your run. Since
most applications behave similarly on each node, you may choose to only profile
1 process. As an example, if I wanted to profile only the final node of a 16
node run, I would use the following command:

    aprun -n 15 -N 1 ./a.out : -n 1 -N 1 ./nvprof_timeline.sh ./a.out

### Gathering Metrics for Analysis ###
Additionally you may wish to gather detailed information about each kernel.
This can be done by running a second time with the `nvprof_metrics.sh` script.
This adds a significant amount of overhead to the run, so it should only be
done on runs that last only a few seconds.

## Importing into Visual Profiler ##
Although Visual Profiler is available as a part of the cudatoolkit module on
the Cray XK7 running CUDA Visual Profiler from your local machine. In order to
load the nvprof output into Visual Profiler, use the `File -> Import` option
and select an nvprof file as the type, then select your file. You should not
need to change any other options. 
