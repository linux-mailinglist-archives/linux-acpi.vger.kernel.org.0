Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92B948E7
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfHSPrR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 11:47:17 -0400
Received: from mail.klausen.dk ([174.138.9.187]:43656 "EHLO mail.klausen.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfHSPpt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:49 -0400
Subject: Re: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to
 suspend-to-idle
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klausen.dk; s=dkim;
        t=1566229545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHPVcICGJOxJGFNuKHwnQFj41i8YywgMjCbyckw+LBo=;
        b=aGWQLCf4A3BSvopyQWBEAVrbaVx9JBwYGnDY2mx+LjfJzEKebv9PjBiApdXzjL+YydwzCU
        KLO0sGc7zBCXis7ve+/cPbo0sGqPl1rSp4Enh2J/nWFIYTrj4+rznQ6tCb4rUaGs1+Epde
        TPuAh/Pf9y9fMl1JU8I3ipKJwbZpv+A=
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <5997740.FPbUVk04hV@kreacher>
 <800186a2-e912-3498-f08b-47469bbe8b0d@klausen.dk>
 <CAJZ5v0hfMS6aJP9G=dhZZ+3WTzM8=DzQkdJ7s9W3m5m9Dat5=g@mail.gmail.com>
 <1585707.yWhsc4YUgi@kreacher>
From:   Kristian Klausen <kristian@klausen.dk>
Message-ID: <6bf51526-edf3-6698-b251-ef0c94b766fc@klausen.dk>
Date:   Mon, 19 Aug 2019 17:45:44 +0200
MIME-Version: 1.0
In-Reply-To: <1585707.yWhsc4YUgi@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 19.08.2019 11.05, Rafael J. Wysocki wrote:
> On Monday, August 19, 2019 9:59:02 AM CEST Rafael J. Wysocki wrote:
>> On Fri, Aug 16, 2019 at 10:26 PM Kristian Klausen <kristian@klausen.dk> wrote:
>>> On 02.08.2019 12.33, Rafael J. Wysocki wrote:
>>>> Hi All,
>>>>
>>>>>> On top of the "Simplify the suspend-to-idle control flow" patch series
>>>>>> posted previously:
>>>>>>
>>>>>> https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/
>>>>>>
>>>>>> sanitize the suspend-to-idle flow even further.
>>>>>>
>>>>>> First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).
>>>>>>
>>>>>> Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
>>>>>> specification-compliant order with respect to suspending and resuming
>>>>>> devices (patch 2).
>>>>>>
>>>>>> Finally, rearrange lps0_device_attach() (patch 3) and add a command line
>>>>>> switch to prevent the LPS0 _DSM from being used.
>>>>> The v2 is because I found a (minor) bug in patch 1, decided to use a module
>>>>> parameter instead of a kernel command line option in patch 4.  Also, there
>>>>> are 4 new patches:
>>>>>
>>>>> Patch 5: Switch the EC over to polling during "noirq" suspend and back
>>>>> during "noirq" resume.
>>>>>
>>>>> Patch 6: Eliminate acpi_sleep_no_ec_events().
>>>>>
>>>>> Patch 7: Consolidate some EC code depending on PM_SLEEP.
>>>>>
>>>>> Patch 8: Add EC GPE dispatching debug message.
>>>> The v3 is just a rearranged v2 so as to move the post sensitive patch (previous patch 2)
>>>> to the end of the series.   [After applying the full series the code is the same as before.]
>>>>
>>>> For easier testing, the series (along with some previous patches depended on by it)
>>>> is available in the pm-s2idle-testing branch of the linux-pm.git tree at kernel.org:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-s2idle-testing
>>> It was just testing this patch series(461fc1caed55), to see if it would
>>> fix my charging issue
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=201307), which it didn't.
>> It is unlikely to help in that case.
Do you have any idea what the issue could be?
>>
>>> I did however notice that my laptop (ASUS Zenbook UX430UNR/i7-8550U)
>>> won't wake when opening the lid or pressing a key, the only way to wake
>>> the laptop is pressing the power button.
>>>
>>> I also tested mainline (5.3.0-rc4 b7e7c85dc7b0) and 5.2.8 and the laptop
>>> wakes without issue when the lid is opened or a key is presed.
>>>> Please refer to the changelogs for details.
>> Thanks for your report.
>>
>> I seem to see a similar issue with respect to the lid on one of my
>> test machines, looking into it right now.
> Well, my lid issue seems to be unrelated as it doesn't result from any patches in the
> series in question.
>
> First off, please clone 5.3-rc5 from kernel.org and double check if the issue is not
> present in that one.
>
> If that's not the case, merge the pm-s2idle-rework branch from my tree on top of it
> and retest.
>
> If you still see the issue then, apply the appended patch (on top of the pm-s2idle-reqork
> branch ) and, after starting the kernel, do
>
> # echo 1 > /sys/power/pm_debug_messages
>
> suspend the system and try to wake it up through all of the ways that stopped working.
>
> Then, wake it up with the power button, save the output of dmesg and send it to me.
>
> Thanks!

With 5.3-rc5 the laptops wakes up without any issue when pressing a key 
or opening the lid.
With v5.3-rc5+pm-s2idle-testing I can only wake the laptop by pressing 
the power button.

dmesg with pm_debug_messages=1 and your patch:
[   55.646109] PM: suspend entry (s2idle)
[   55.698559] Filesystems sync: 0.052 seconds
[   55.698561] PM: Preparing system for sleep (s2idle)
[   55.700661] Freezing user space processes ... (elapsed 0.210 seconds) 
done.
[   55.911494] OOM killer disabled.
[   55.911495] Freezing remaining freezable tasks ... (elapsed 0.001 
seconds) done.
[   55.913192] PM: Suspending system (s2idle)
[   55.913195] printk: Suspending console(s) (use no_console_suspend to 
debug)
[   55.914778] [drm] CT: disabled
[   55.916057] wlan0: deauthenticating from 64:70:02:a5:fd:02 by local 
choice (Reason: 3=DEAUTH_LEAVING)
[   56.045634] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[   56.046650] sd 2:0:0:0: [sda] Stopping disk
[   56.287622] PM: suspend of devices complete after 371.285 msecs
[   56.287627] PM: start suspend of devices complete after 373.684 msecs
[   56.307155] PM: late suspend of devices complete after 19.477 msecs
[   56.312479] ACPI: EC: interrupt blocked
[   56.352761] PM: noirq suspend of devices complete after 45.205 msecs
[   56.352770] ACPI: \_PR_.PR00: LPI: Device not power manageable
[   56.352774] ACPI: \_PR_.PR01: LPI: Device not power manageable
[   56.352776] ACPI: \_PR_.PR02: LPI: Device not power manageable
[   56.352779] ACPI: \_PR_.PR03: LPI: Device not power manageable
[   56.352782] ACPI: \_PR_.PR04: LPI: Device not power manageable
[   56.352785] ACPI: \_PR_.PR05: LPI: Device not power manageable
[   56.352788] ACPI: \_PR_.PR06: LPI: Device not power manageable
[   56.352790] ACPI: \_PR_.PR07: LPI: Device not power manageable
[   56.352793] ACPI: \_SB_.PCI0.GFX0: LPI: Device not power manageable
[   56.352800] ACPI: \_SB_.PCI0.RP06.PXSX: LPI: Device not power manageable
[   56.357057] PM: suspend-to-idle
[   69.338656] PM: Timekeeping suspended for 12.178 seconds
[   69.338701] PM: irq_pm_check_wakeup: IRQ 9
[   69.338704] PM: IRQ wakeup: IRQ 9
[   69.338879] PM: resume from suspend-to-idle
[   69.371406] ACPI: EC: interrupt unblocked
[   69.514126] PM: noirq resume of devices complete after 142.668 msecs
[   69.516007] PM: early resume of devices complete after 1.773 msecs
[   69.517579] [drm] HuC: Loaded firmware i915/kbl_huc_ver02_00_1810.bin 
(version 2.0)
[   69.521691] [drm] GuC: Loaded firmware i915/kbl_guc_32.0.3.bin 
(version 32.0)
[   69.521764] [drm] CT: enabled
[   69.521850] i915 0000:00:02.0: GuC firmware version 32.0
[   69.521853] i915 0000:00:02.0: GuC submission disabled
[   69.521855] i915 0000:00:02.0: HuC enabled
[   69.527165] sd 2:0:0:0: [sda] Starting disk
[   69.528076] iwlwifi 0000:02:00.0: Applying debug destination 
EXTERNAL_DRAM
[   69.661997] iwlwifi 0000:02:00.0: Applying debug destination 
EXTERNAL_DRAM
[   69.729645] iwlwifi 0000:02:00.0: FW already configured (0) - 
re-configuring
[   69.842657] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   69.844600] ata3.00: configured for UDMA/133
[   69.949032] PM: resume of devices complete after 432.157 msecs
[   69.949770] PM: Finishing wakeup.
[   69.949771] OOM killer enabled.
[   69.949772] Restarting tasks ...
[   69.953029] mei_hdcp mei::b638ab7e-94e2-4ea2-a552-d1c54b627f04:01: 
bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[   69.953521] done.
[   70.012592] PM: suspend exit
>
> ---
>   drivers/acpi/sleep.c        |    4 ++--
>   drivers/base/power/wakeup.c |    2 ++
>   kernel/irq/pm.c             |    2 ++
>   3 files changed, 6 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -1012,9 +1012,9 @@ static void acpi_s2idle_wake(void)
>   		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
>   		acpi_ec_flush_work();
>   		acpi_os_wait_events_complete(); /* synchronize Notify handling */
> -	}
>   
> -	rearm_wake_irq(acpi_sci_irq);
> +		rearm_wake_irq(acpi_sci_irq);
> +	}
>   }
>   
>   static void acpi_s2idle_restore_early(void)
> Index: linux-pm/drivers/base/power/wakeup.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeup.c
> +++ linux-pm/drivers/base/power/wakeup.c
> @@ -871,6 +871,8 @@ void pm_wakeup_clear(bool reset)
>   
>   void pm_system_irq_wakeup(unsigned int irq_number)
>   {
> +	pm_pr_dbg("IRQ wakeup: IRQ %u\n", irq_number);
> +
>   	if (pm_wakeup_irq == 0) {
>   		pm_wakeup_irq = irq_number;
>   		pm_system_wakeup();
> Index: linux-pm/kernel/irq/pm.c
> ===================================================================
> --- linux-pm.orig/kernel/irq/pm.c
> +++ linux-pm/kernel/irq/pm.c
> @@ -15,6 +15,8 @@
>   
>   bool irq_pm_check_wakeup(struct irq_desc *desc)
>   {
> +	pm_pr_dbg("%s: IRQ %u\n", __func__, irq_desc_get_irq(desc));
> +
>   	if (irqd_is_wakeup_armed(&desc->irq_data)) {
>   		irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
>   		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
>
>
>
>
>

