Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72D88792D
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2019 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406652AbfHIMA4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Aug 2019 08:00:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57124 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfHIMA4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Aug 2019 08:00:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190809120053euoutp016bf00dc649676ab83ac42d5f63f10e40~5P2Y7C6nF1608616086euoutp01B
        for <linux-acpi@vger.kernel.org>; Fri,  9 Aug 2019 12:00:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190809120053euoutp016bf00dc649676ab83ac42d5f63f10e40~5P2Y7C6nF1608616086euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565352053;
        bh=BguYn9oSKX3oR2DpH4Tlz7VIQ63AI8ONmZSbhpncKJI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WYTQsRdyIT+gO9Nr03W8QscR0R2RkPppEMiMTXjPhafxswCOVnWqz8Iu6z5wMhN61
         MnnxDcPBc1pfk2XXBZf55PRcO2YRTFbiIr69aZkgNxje5qs71eeiA1kIGu5bSwhC4G
         cVQgxoGS7lTQpEvk/6c+jKvI9ERBFVlIesKojy98=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190809120053eucas1p1ad487fb702b2b6e22d921dd835e641c7~5P2YRtewy0290802908eucas1p1u;
        Fri,  9 Aug 2019 12:00:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 79.F8.04309.4706D4D5; Fri,  9
        Aug 2019 13:00:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190809120052eucas1p11b56806662ef4f4efb82a152ad651481~5P2XXg1ZR1930019300eucas1p1d;
        Fri,  9 Aug 2019 12:00:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190809120051eusmtrp11cde85396d93e0614b448be140078949~5P2XJLYYa2105621056eusmtrp1T;
        Fri,  9 Aug 2019 12:00:51 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-33-5d4d607400d0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.E1.04117.3706D4D5; Fri,  9
        Aug 2019 13:00:51 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190809120051eusmtip2418eca23ed93ef2612ceeda4369560d1~5P2WpxVF-1650316503eusmtip2S;
        Fri,  9 Aug 2019 12:00:51 +0000 (GMT)
Subject: Re: [PATCH v3 8/8] ACPI: PM: s2idle: Execute LPS0 _DSM functions
 with suspended devices
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1b181f35-29c3-c6ce-6c42-ae55e890579e@samsung.com>
Date:   Fri, 9 Aug 2019 14:00:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <74514118.QN1Ey1fWSL@kreacher>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7olCb6xBr3zjSx6m6YzWfzrXsZm
        sXxfP6PF5V1z2Cw+9x5htGjqbGKzOPwl0eLM6UusFk8e9rE5cHrMauhl85g0cwazx+I9L5k8
        5p0M9NhytZ3F4/MmuQC2KC6blNSczLLUIn27BK6MXx0L2As+ulS0H5rO1MB4waKLkZNDQsBE
        YuPqX4xdjFwcQgIrGCU6P55jhXC+MEocvXOJEaRKSOAzo8Ty7aZdjBxgHYu2+kHULGeU6H7Z
        wg7hvGWU+Dn9JitIg7BAkkTv3L/sILaIQJjE7eVvmUGKmAX2MUncvLCIGSTBJmAo0fW2iw3E
        5hWwk/jTc4oFxGYRUJH4vu80WI2oQIzEzjc9zBA1ghInZz4Bq+EU0Jb4v/Mz2DJmAXmJ5q2z
        mSFscYlbT+YzgSyTEDjGLnHhwXpmiEddJA6s+QVlC0u8Or6FHcKWkTg9uYcFoqGZUeLhubXs
        EE4Po8TlphmMEFXWEoePX2QFBQCzgKbE+l36EGFHiX2XNzJCwoVP4sZbQYgj+CQmbZvODBHm
        lehoE4KoVpOYdXwd3NqDFy4xT2BUmoXktVlI3pmF5J1ZCHsXMLKsYhRPLS3OTU8tNspLLdcr
        TswtLs1L10vOz93ECExPp/8d/7KDcdefpEOMAhyMSjy8DYo+sUKsiWXFlbmHGCU4mJVEeK9w
        +MYK8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYNQ+um3+
        Bv16t7obtVFFvh8e79nPun/TVWc9pn9/5I80qcoc5fuyQHJO9zTDeZ/eMNidX6UX3iK30jn/
        +/SdbQ/2FEmt1VD+cYNdTe2g3DLzVPmJd+/qy1T6zRP5+FNYOfHda78NN0O1pY8VXdKsYGae
        /PLi+4t1v854L7jgN/dHcMnWoq18fH5KLMUZiYZazEXFiQAYqaSjSwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7rFCb6xBm92G1n0Nk1nsvjXvYzN
        Yvm+fkaLy7vmsFl87j3CaNHU2cRmcfhLosWZ05dYLZ487GNz4PSY1dDL5jFp5gxmj8V7XjJ5
        zDsZ6LHlajuLx+dNcgFsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2
        Kak5mWWpRfp2CXoZvzoWsBd8dKloPzSdqYHxgkUXIweHhICJxKKtfl2MXBxCAksZJU4272bq
        YuQEistInJzWwAphC0v8udbFBmILCbxmlPiyzA3EFhZIkjj9rY0dxBYRCJPoXPiHEWQQs8AB
        JonNl5YzQTR4SOze8AasiE3AUKLrLcQgXgE7iT89p1hAbBYBFYnv+04zg9iiAjES+85sZ4eo
        EZQ4OfMJWA2ngLbE/52fwQ5iFjCTmLf5ITOELS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nL
        LCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG47ZjP7fsYOx6F3yIUYCDUYmHV0Pe
        J1aINbGsuDL3EKMEB7OSCO8VDt9YId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJoq8knhD
        U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MM1foa3j3fZN74MXW4sKW
        dMu/VPLnsx0zdSoPfdmn55t0UjlLm3e/rP/ziYtz+ascglVifda9iI9LOhli9SdmRk+iSMiK
        Hd9MJAp0dRiiFY4eVzt+xuFBurt5h/y0aYeKtq1eMHEK74Qin9VJJVP2JTukxP5cdp3hMZfA
        gofnhB/xpcSJHFdUYinOSDTUYi4qTgQAIypdV9wCAAA=
X-CMS-MailID: 20190809120052eucas1p11b56806662ef4f4efb82a152ad651481
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190809120052eucas1p11b56806662ef4f4efb82a152ad651481
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190809120052eucas1p11b56806662ef4f4efb82a152ad651481
References: <5997740.FPbUVk04hV@kreacher> <74514118.QN1Ey1fWSL@kreacher>
        <CGME20190809120052eucas1p11b56806662ef4f4efb82a152ad651481@eucas1p1.samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 2019-08-02 12:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> According to Section 3.5 of the "Intel Low Power S0 Idle" document [1],
> Function 5 of the LPS0 _DSM is expected to be invoked when the system
> configuration matches the criteria for entering the target low-power
> state of the platform.  In particular, this means that all devices
> should be suspended and in low-power states already when that function
> is invoked.
>
> This is not the case currently, however, because Function 5 of the
> LPS0 _DSM is invoked by it before the "noirq" phase of device suspend,
> which means that some devices may not have been put into low-power
> states yet at that point.  That is a consequence of the previous
> design of the suspend-to-idle flow that allowed the "noirq" phase of
> device suspend and the "noirq" phase of device resume to be carried
> out for multiple times while "suspended" (if any spurious wakeup
> events were detected) and the point of the LPS0 _DSM Function 5
> invocation was chosen so as to call it (and LPS0 _DSM Function 6
> analogously) once per suspend-resume cycle (regardless of how many
> times the "noirq" phases of device suspend and resume were carried
> out while "suspended").
>
> Now that the suspend-to-idle flow has been redesigned to carry out
> the "noirq" phases of device suspend and resume once in each cycle,
> the code can be reordered to follow the specification that it is
> based on more closely.
>
> For this purpose, add ->prepare_late and ->restore_early platform
> callbacks for suspend-to-idle, to be executed, respectively, after
> the "noirq" phase of suspending devices and before the "noirq"
> phase of resuming them and make ACPI use them for the invocation
> of LPS0 _DSM functions as appropriate.
>
> While at it, move the LPS0 entry requirements check to be made
> before invoking Functions 3 and 5 of the LPS0 _DSM (also once
> per cycle) as follows from the specification [1].
>
> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> In v2 this was patch 2.
>
> ---
>   drivers/acpi/sleep.c    |   36 ++++++++++++++++++++++++------------
>   include/linux/suspend.h |    2 ++
>   kernel/power/suspend.c  |   12 +++++++++---
>   3 files changed, 35 insertions(+), 15 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -954,11 +954,6 @@ static int acpi_s2idle_begin(void)
>   
>   static int acpi_s2idle_prepare(void)
>   {
> -	if (lps0_device_handle && !sleep_no_lps0) {
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> -	}
> -
>   	if (acpi_sci_irq_valid())
>   		enable_irq_wake(acpi_sci_irq);
>   
> @@ -972,11 +967,22 @@ static int acpi_s2idle_prepare(void)
>   	return 0;
>   }
>   
> -static void acpi_s2idle_wake(void)
> +static int acpi_s2idle_prepare_late(void)
>   {
> -	if (lps0_device_handle && !sleep_no_lps0 && pm_debug_messages_on)
> +	if (!lps0_device_handle || sleep_no_lps0)
> +		return 0;
> +
> +	if (pm_debug_messages_on)
>   		lpi_check_constraints();
>   
> +	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> +	acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> +
> +	return 0;
> +}
> +
> +static void acpi_s2idle_wake(void)
> +{
>   	/*
>   	 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the SCI has
>   	 * not triggered while suspended, so bail out.
> @@ -1011,6 +1017,15 @@ static void acpi_s2idle_wake(void)
>   	rearm_wake_irq(acpi_sci_irq);
>   }
>   
> +static void acpi_s2idle_restore_early(void)
> +{
> +	if (!lps0_device_handle || sleep_no_lps0)
> +		return;
> +
> +	acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> +	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> +}
> +
>   static void acpi_s2idle_restore(void)
>   {
>   	s2idle_wakeup = false;
> @@ -1021,11 +1036,6 @@ static void acpi_s2idle_restore(void)
>   
>   	if (acpi_sci_irq_valid())
>   		disable_irq_wake(acpi_sci_irq);
> -
> -	if (lps0_device_handle && !sleep_no_lps0) {
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> -	}
>   }
>   
>   static void acpi_s2idle_end(void)
> @@ -1036,7 +1046,9 @@ static void acpi_s2idle_end(void)
>   static const struct platform_s2idle_ops acpi_s2idle_ops = {
>   	.begin = acpi_s2idle_begin,
>   	.prepare = acpi_s2idle_prepare,
> +	.prepare_late = acpi_s2idle_prepare_late,
>   	.wake = acpi_s2idle_wake,
> +	.restore_early = acpi_s2idle_restore_early,
>   	.restore = acpi_s2idle_restore,
>   	.end = acpi_s2idle_end,
>   };
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -253,13 +253,19 @@ static int platform_suspend_prepare_late
>   
>   static int platform_suspend_prepare_noirq(suspend_state_t state)
>   {
> -	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare_late ?
> -		suspend_ops->prepare_late() : 0;
> +	if (state == PM_SUSPEND_TO_IDLE) {
> +		if (s2idle_ops && s2idle_ops->prepare_late)
> +			return s2idle_ops->prepare_late();
> +	}
> +	return suspend_ops->prepare_late ? suspend_ops->prepare_late() : 0;

This unconditionally references suspend_ops here, what wasn't done 
earlier. On one of my test boards (OdroidXU) it causes following NULL 
pointer dereference since Linux next-20190809 (the first -next, which 
contains this patch):

root@target:~# time rtcwake -s10 -mmem
rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Aug  9 12:21:43 2019
PM: suspend entry (s2idle)
Filesystems sync: 0.001 seconds
Freezing user space processes ... (elapsed 0.002 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
wake enabled for irq 111
usb3503 4-0008: switched to STANDBY mode
samsung-pinctrl 13400000.pinctrl: No retention data configured bank with 
external wakeup interrupt. Wake-up mask will not be set.
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
pgd = ac9cf656
[0000000c] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 2027 Comm: rtcwake Not tainted 5.3.0-rc3-next-20190809 #6373
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
PC is at suspend_devices_and_enter+0x330/0xf2c
LR is at lock_is_held_type+0x80/0x108
pc : [<c0195b78>]    lr : [<c01883dc>]    psr: 60000013
sp : e73dfe20  ip : 00000001  fp : 00000001
r10: c10b9394  r9 : c10ce36c  r8 : c1007648
r7 : c16d26c8  r6 : 00000001  r5 : 00000000  r4 : c16d26dc
r3 : 00000000  r2 : 00000000  r1 : c1014220  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 671ac06a  DAC: 00000051
Process rtcwake (pid: 2027, stack limit = 0x59af371a)
Stack: (0xe73dfe20 to 0xe73e0000)
...
[<c0195b78>] (suspend_devices_and_enter) from [<c0196d0c>] 
(pm_suspend+0x598/0xcb8)
[<c0196d0c>] (pm_suspend) from [<c0194848>] (state_store+0x6c/0xc8)
[<c0194848>] (state_store) from [<c0330100>] (kernfs_fop_write+0x100/0x1e0)
[<c0330100>] (kernfs_fop_write) from [<c02a1594>] (__vfs_write+0x30/0x1d0)
[<c02a1594>] (__vfs_write) from [<c02a4090>] (vfs_write+0xa4/0x180)
[<c02a4090>] (vfs_write) from [<c02a42f0>] (ksys_write+0x60/0xdc)
[<c02a42f0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xe73dffa8 to 0xe73dfff0)
...
---[ end trace 627069b7dfd482c9 ]---

>   }
>   
>   static void platform_resume_noirq(suspend_state_t state)
>   {
> -	if (state != PM_SUSPEND_TO_IDLE && suspend_ops->wake)
> +	if (state == PM_SUSPEND_TO_IDLE) {
> +		if (s2idle_ops && s2idle_ops->restore_early)
> +			s2idle_ops->restore_early();
> +	} else if (suspend_ops->wake)
>   		suspend_ops->wake();
>   }
>   
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -190,7 +190,9 @@ struct platform_suspend_ops {
>   struct platform_s2idle_ops {
>   	int (*begin)(void);
>   	int (*prepare)(void);
> +	int (*prepare_late)(void);
>   	void (*wake)(void);
> +	void (*restore_early)(void);
>   	void (*restore)(void);
>   	void (*end)(void);
>   };

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

