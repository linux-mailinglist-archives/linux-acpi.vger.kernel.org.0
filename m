Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427C21FA9CF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jun 2020 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFPHOw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jun 2020 03:14:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:57977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgFPHOv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jun 2020 03:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592291678;
        bh=EuUBO0VmlPFaxt3vLnX3dhOWmNeNwX7SoxPFN6RUYuA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=HAp8mr0YJI1iS0IjVLoARG4pStqtvDWuJS6hnG3SSpw6U3UA/KyrSo22t7HKLJp2N
         CxjxWx3LMkPxRwk331El8+norZ0/gGtQ2CaNePr6mOZEvyThdILvEQJq6W07BytxC0
         IcPDbwZjLoj3JY1fa4iXJukoWUtweYAugnRkIZ/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([92.73.64.60]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHs0-1isj3s2LV4-00tjs4; Tue, 16
 Jun 2020 09:14:38 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87y2owwo2o.fsf@rub.de>
        <20200609202339.cgy57twm2zdtjhje@linutronix.de>
        <87tuzjcovq.fsf@gmx.net>
        <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
        <87imfyh6yx.fsf@gmx.net> <87wo4dligz.fsf@gmx.net>
        <20200612110122.jossn5zrktcvpbpm@linutronix.de>
        <87tuzdrgm5.fsf@gmx.net>
        <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
        <874krcsquv.fsf@gmx.net>
        <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
Date:   Tue, 16 Jun 2020 09:14:37 +0200
In-Reply-To: <20200615145130.bcdidqkp6w23xb6c@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Mon, 15 Jun 2020 16:51:30 +0200")
Message-ID: <87tuzbh482.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:ov6gSU6GyFb0newgb6X1LcpeaWyBhJsLfz7JhwYU/WzbUWsGhHH
 uSqv59iDkkdpQiwfi0hxGmt7Jm+3HtdBRII+k5GoZ0eH7Hv9fBeesI54h8Rd66MjMIYl0aL
 0XvCPCCkPvAKxz/n7jg7oWt0HjOtjEP65RE2jjFz6WF8TK6UIuqIET7bFidI4pR+yHrVeaP
 xY63JaRKCbSgUhSHfTG/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JtbKXg+tQHE=:cuxWp1wgSoKdAifW05ucVS
 dYDhQyAunLrzEpGMmSAj+KIawSGZ2h52FlDkotjWCTuwFBic+xu3bm7PlEmay7OyKtHNb+5Z6
 e0Pv2/acSDCqHQgxsU1WiU2o4rjN1BWV564RKu1Nef5nz9ac5zk5hVv3CO0+RP+bM1ECJPWI4
 4X2DvyBxF+TRNt8Iek2P+HZSXabxwY4N9ZWVNl7REYiHVFyKTLxcPPHq2YFb1H0xL4At/0VAG
 iZYU4wGpcCadx3829mC0vPNAO1bnsOqYuk2G9HXw0dIGHqxkjoQQnAVY9cyC31RqqsnvQB6W7
 /9ebwC2Wqs0Jpu+fLlRP4U0l+qdEj+DbaUo60xYf9gm/W5CoeouM2mvvMumxDwDSdCdZHM2Fs
 corkiS8f22xkaT4dlsJhsLqsJNo05ULXGvFgdeuIw0dNPEY5D/2EnRpapj3ZJQhMLpmqUZepl
 OpMk451oTiP42nKGisB6FEPtIHhE59XZn3tEEZEhmyfFhhKmrf0T02HSvIta2ZJ/Uq4n0xwo9
 5TE13k5Z2uLhoDkCdR5vZA0lfcjySIbv/Tgd43QvdoBT8AgklEbJC3Kiq4a/YB4nYqtBd8Lrm
 2p5xCxH6VqD9O6aT49odUookX7vMbpbK7pAFTjvrP2iZoIYBJYGoLjBthIBFvhRAoT2fFX98F
 /rPoz46+yHDnttVTdQoA+EN28+Ezm5RUC36M4vAHY1tpIjrlagJF8FWCKOvXvdVSMhdE3YVDZ
 USKNK7PFsGQGdy+b5dLHzBZK6s7P9PbhqyJUB2WDgq9Z+OUbM7V59KypSyNWC7gIyIsFctqVl
 ofeQzDyGyHKrikxFdzZ3fv2pYDpCcy2r0dOuYZueFh3NEVqNIQNRr2vcFu+tfvX+IhjTJxnw6
 eKQwj6MJMndMerYMSmjwAeqNJYdLn6MWR7AoTDUVXgx4aWnVm8+ZsrHsXkDUG/CH2G1OjRm7O
 FEqRURr9K4RHM0QqUNs9dZ+eThtLuKutYGOECRl8JsaJHxawiFkdgsctc/GtNrxkGOYncbDSL
 fgRa12ytikSnXUuyCxc+x+vo0gDXfLhMx3dnmeEf5X0jTluHZaa77NhBl7tc0//wEIqFtVl1+
 xgqL257x51axS3EVufBEUmN7vt4DJh7CFLZhZBRgUR/ij8vn+TaIqI245YzqbrmShFa7H00cv
 twXKSB/AMYDPllyXB7nSPU5Kz/AG70aHmbXv7FycmY8Pdqd+n02x0ZwU/Gb2IOYVHU/CRaKAU
 gQeOEM3J2oaVJgH0S
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 15 Jun 2020 16:51:30 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I attached a modified acpi_dbg.patch. Please enable:
> - CONFIG_ACPI_DEBUG=y
>
> Looking at your 5.1 you have tracing enabled (hope it still is).
>
> The attached patch will dump the date into the tracing buffer, so you
> console should remain "clean". Once it records 300 of those "requests
> for acpi_ev_notify_dispatch" it will stop recording.
> After 4-5 minutes please do
> 	cat /sys/kernel/debug/tracing/trace > file.txt
>
> compress it and send it.

I set CONFIG_ACPI_DEBUG=y, applied the patch and rebuilt 5.6.4, but:

$ cat /sys/kernel/debug/tracing/trace > trace.txt
cat: /sys/kernel/debug/tracing/trace: No such file or directory

Here are all the 5.6.4 config options with "TRACING" or "TRACE"; do I
need to set any that aren't set?

CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_TRACEPOINTS=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_IWLWIFI_DEVICE_TRACING=y
# CONFIG_TRACE_SINK is not set
# HW tracing support
# end of HW tracing support
CONFIG_STACKTRACE=y
CONFIG_RCU_TRACE=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACE_CLOCK=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_BACKTRACE_SELF_TEST is not set

Steve Berman
