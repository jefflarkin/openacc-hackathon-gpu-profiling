! Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
!   Jeff Larkin
! Fortran bindings for a small subset of the NVIDIA Tools Extensions library
module nvtx
  use iso_c_binding
  public :: nvtxrangepusha, nvtxrangepop
  public :: nvtxrangepushaargb
  interface
    ! Annotate the timeline with a message
    ! Parameters:
    ! * string : the message in a string format
    subroutine nvtxrangepusha(string) bind(C, name="nvtxRangePushA")
      use iso_c_binding , only : c_char
      character(kind=c_char) :: string(*)
    end subroutine nvtxrangepusha

    ! Annotate the timeline with both a message and an ARGB color
    ! Parameters:
    ! * string : the message in a string format
    ! * argb   : the color in argb format (example: Z'FF880000'
    subroutine nvtxrangepushaargb(string,argb) bind(C, name="_nvtxRangePushAARGB")
      use iso_c_binding , only : c_char, c_int
      character(kind=c_char) :: string(*)
      integer(kind=c_int)  :: argb
    end subroutine nvtxrangepushaargb

    ! Pop the last range off the stack
    subroutine nvtxrangepop() bind(C, name="nvtxRangePop")
    end subroutine
  end interface
end module nvtx
