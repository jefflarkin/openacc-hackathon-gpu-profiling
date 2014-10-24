/* 
 * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
 *
 *   Jeff Larkin
 */
#include <nvToolsExt.h>
/*
 * Utility routine for marking a range with both
 * a message and a color from a single function call.
 */
extern "C" 
void _nvtxRangePushAARGB(char *message, int argb)
{
  nvtxEventAttributes_t eventAttrib = {0};
  eventAttrib.version = NVTX_VERSION;
  eventAttrib.size = NVTX_EVENT_ATTRIB_STRUCT_SIZE;
  eventAttrib.colorType = NVTX_COLOR_ARGB;
  eventAttrib.color = argb;
  eventAttrib.messageType = NVTX_MESSAGE_TYPE_ASCII;
  eventAttrib.message.ascii = message;
  nvtxRangePushEx(&eventAttrib);
}
