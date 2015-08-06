//#include "lwip_rtems_tcp_echo_test.h"
#include <bsp.h>
int mainEcho(void);
/*----------------------------------------------------------------------------*/
void* POSIX_Init()
{
    /* Initialize echo test. */
    mainEcho();
    return NULL;
}
/*----------------------------------------------------------------------------*/

#define CONFIGURE_APPLICATION_NEEDS_CONSOLE_DRIVER
#define CONFIGURE_APPLICATION_NEEDS_CLOCK_DRIVER

//#define CONFIGURE_MICROSECONDS_PER_TICK 1000 /* 1 millisecond */
//#define CONFIGURE_TICKS_PER_TIMESLICE   20   /* 20 milliseconds */

#define CONFIGURE_MAXIMUM_POSIX_THREADS                   10
#define CONFIGURE_MAXIMUM_POSIX_MUTEXES                   21
#define CONFIGURE_MAXIMUM_POSIX_CONDITION_VARIABLES       20
#define CONFIGURE_MAXIMUM_POSIX_KEYS                      10
#define CONFIGURE_MAXIMUM_POSIX_TIMERS                    5
#define CONFIGURE_MAXIMUM_POSIX_QUEUED_SIGNALS            4
#define CONFIGURE_MAXIMUM_POSIX_MESSAGE_QUEUES            4
#define CONFIGURE_MAXIMUM_POSIX_MESSAGE_QUEUE_DESCRIPTORS CONFIGURE_MAXIMUM_POSIX_MESSAGE_QUEUES
#define CONFIGURE_MAXIMUM_POSIX_SEMAPHORES                10
#define CONFIGURE_MAXIMUM_POSIX_BARRIERS                  3
#define CONFIGURE_MAXIMUM_POSIX_SPINLOCKS                 5
#define CONFIGURE_MAXIMUM_POSIX_RWLOCKS                   5

#define CONFIGURE_MAXIMUM_TASKS                10
#define CONFIGURE_MINIMUM_TASK_STACK_SIZE      0
#define CONFIGURE_IDLE_TASK_STACK_SIZE         2000
#define CONFIGURE_POSIX_INIT_THREAD_STACK_SIZE 120000
#define CONFIGURE_EXTRA_TASK_STACKS            240000

#define CONFIGURE_USE_DEVFS_AS_BASE_FILESYSTEM

#ifdef LWIP_DEBUG
#define CONFIGURE_STACK_CHECKER_ENABLED
#define CONFIGURE_MALLOC_STATISTICS
#endif /* LWIP_DEBUG */

#define CONFIGURE_POSIX_INIT_THREAD_TABLE
#define CONFIGURE_INIT
#define RTEMS_DEBUG_OBJECT_ALLOCATION
#include <rtems/confdefs.h>
