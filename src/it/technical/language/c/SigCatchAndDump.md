---
title: "C语言发生问题产生log并crash dump"
tags: C
---

{% highlight c %}
/* This is the crash handler.
 * Does a best effort at logging and calls _exit to terminate
 * the process immediately (without atexit handlers, etc.) */
void __stack_chk_fail(void)
{
    struct sigaction sa;
    sigset_t sigmask;
    static const char message[] = "stack corruption detected: aborted";
    char path[PATH_MAX];
    int count;

    /* Immediately block all (but SIGABRT) signal handlers from running code */
    sigfillset(&sigmask);
    sigdelset(&sigmask, SIGABRT);
    sigprocmask(SIG_BLOCK, &sigmask, NULL);

    /* temporary, so deliver SIGSEGV can be caught by debuggerd */
    sigemptyset(&sigmask);
    sigaddset(&sigmask, SIGSEGV);
    sigprocmask(SIG_UNBLOCK, &sigmask, NULL);

    /* Use /proc/self/exe link to obtain the program name for logging
     * purposes. If it's not available, we set it to "<unknown>" */
    if ((count = readlink("/proc/self/exe", path, sizeof(path) - 1)) == -1) {
        strlcpy(path, "<unknown>", sizeof(path));
    } else {
        path[count] = '\0';
    }

    /* Do a best effort at logging. This ends up calling writev(2) */
    __libc_android_log_print(ANDROID_LOG_FATAL, path, message);

    /* Make sure there is no default action for SIGABRT */
    bzero(&sa, sizeof(struct sigaction));
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    sa.sa_handler = SIG_DFL;
    sigaction(SIGABRT, &sa, NULL);

    /* temporary, so stack overflow case can be caught */
    *((long*)0xdead2aed) = 0xaed;
    /* Terminate the process and exit immediately */
    kill(getpid(), SIGABRT);

    _exit(127);
}
{% endhighlight %}
