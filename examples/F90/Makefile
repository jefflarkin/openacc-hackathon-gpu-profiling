#
#  Copyright 2012 NVIDIA Corporation
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

ifneq "$(CRAY_CUDATOOLKIT_DIR)" ""
  CUDA_HOME = $(CRAY_CUDATOOLKIT_DIR)
endif

ifeq "$(PE_ENV)" "CRAY"
F90 = ftn
ACCFLAGS = -rm
CC = CC
else
F90       = pgf90
ACCFLAGS = -acc -ta=nvidia -Minfo=accel
CC = pgCC
endif

BIN =  laplace2d_acc

all: $(BIN)

laplace2d_acc: nvtx.o nvtx_wrapper.o laplace2d.f90
	$(F90) $(ACCFLAGS) -o $@ $^ -L$(CUDA_HOME)/lib64 -lnvToolsExt

nvtx.o: ../../nvtx/nvtx.F90
	$(F90) -c $< -o $@

nvtx_wrapper.o: ../../nvtx/nvtx_wrapper.cpp
	$(CC) -c $< -o $@ -I $(CUDA_HOME)/include

clean:
	$(RM) $(BIN) *.o *.mod *.ptx *.cub
