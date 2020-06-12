Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222A71F7704
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 13:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgFLLBZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgFLLBY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2020 07:01:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC96FC03E96F;
        Fri, 12 Jun 2020 04:01:24 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jjhR4-0002Dr-A5; Fri, 12 Jun 2020 13:01:22 +0200
Date:   Fri, 12 Jun 2020 13:01:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200612110122.jossn5zrktcvpbpm@linutronix.de>
References: <87v9l65d2y.fsf@gmx.net>
 <20200513220428.4nksinis2qs5dtmh@linutronix.de>
 <87mu6aurfn.fsf@gmx.net>
 <20200522164012.ynyvrjompv42jtmx@linutronix.de>
 <87y2owwo2o.fsf@rub.de>
 <20200609202339.cgy57twm2zdtjhje@linutronix.de>
 <87tuzjcovq.fsf@gmx.net>
 <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
 <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wo4dligz.fsf@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+ ACPI in case the ACPI folks see something obvious.

On 2020-06-11 17:39:40 [+0200], Stephen Berman wrote:
> 
> I've done that now.  I've sent you screenshots offlist.  Here's a brief
> summary: The initial shutdown log output is essentially the same as the
> transcription I posted upthread, except that it is interspersed with
> messages from your patch like "Flush hid_reset+0x0/0x80".  Then comes:
> 
> ACPI: Preparing to enter system sleep state S5
> Flushing kacpid
> Flushing kacpid_notify

based on the screenshots and the backtrace you are stuck in is:
- __do_sys_reboot()
  - acpi_power_off_prepare()
    - acpi_os_wait_events_complete()
      - flush_workqueue(kacpi_notify_wq);

> Flushing kacpid_notify over, 0
> Showing busy workqueues and worker pools:
> workqueue events: flags=0x0
>   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
>      pending: drm_fb_helper_diry_work
> workqueue kacpid_notify: flags=0x0
>   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/1 refcnt=4185
>      in-flight: 1578:acpi_os_execute_deferred
>      delayed: acpi_os_execute_deferred, acpi_os_execute_deferred, ...

based on this, the kacpid_notify workqueue has quite some worker piled
up.

> The "acpi_os_execute_deferred" messages were repeated many times in the
> above line, then every 20-30 seconds again for several minutes.  Then
> suddenly a call trace appeared which was similar but not identical to
> the one I posted upthread, and each line of the trace was followed by
> the line ", acpi_os_execute_deferred".  This went by quite quickly even
> with the printk_delay I added, and I was unable to photograph the start
> of it and couldn't get all of the subsequent output, but the screenshots
> show some of it.  After several minutes of this output I again did a
> hard reboot.

All good. I though that you will have one worker that is blocking but
you have a lot of them. It appears that one is active and stuck and more
are waiting.

Could you look at acpi in /proc/interrupts 10 secs apart to see if it
increments?

   grep -E 'acpi|smbus' /proc/interrupts

You could also do "echo t > /proc/sysrq-trigger" which gives you a lot
of task state information, but at the end you will also see "howing busy
workqueues and worker pools:" regarding the workqueue state. I am
curious to see if you already have worker stuck in kacpid_notify with
acpi_os_execute_deferred.

Now that we know that know that acpi_os_execute_deferred() is stuck,
lets shed some light in what it is trying to do. The patch at the end
will dump this information into the console buffer (The `dmesg' command
will print the whole kernel buffer). I have no idea if this starts
printing while the system is running or during shutdown.  I would expect
to see the Start line in acpi_os_execute_deferred() but not the End one. 

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 41168c027a5a4..0e983c558bcb5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -840,7 +840,9 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 {
 	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
 
+	pr_err("%s(%d) Start %px %pF(%px)\n", __func__, __LINE__, dpc, dpc->function, dpc->context);
 	dpc->function(dpc->context);
+	pr_err("%s(%d) End   %px %pF(%px)\n", __func__, __LINE__, dpc, dpc->function, dpc->context);
 	kfree(dpc);
 }
 
@@ -1096,6 +1098,8 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 */
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
+		pr_err("%s(%d) Adding %pS %px\n", __func__, __LINE__, function,
+		       context);
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 	} else if (type == OSL_GPE_HANDLER) {
 		queue = kacpid_wq;
> Steve Berman

Sebastian
