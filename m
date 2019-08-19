Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4D91F9C
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfHSJFO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 05:05:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61376 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJFO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2019 05:05:14 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 6e6f5f4fcc3cee42; Mon, 19 Aug 2019 11:05:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kristian Klausen <kristian@klausen.dk>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to suspend-to-idle
Date:   Mon, 19 Aug 2019 11:05:11 +0200
Message-ID: <1585707.yWhsc4YUgi@kreacher>
In-Reply-To: <CAJZ5v0hfMS6aJP9G=dhZZ+3WTzM8=DzQkdJ7s9W3m5m9Dat5=g@mail.gmail.com>
References: <5997740.FPbUVk04hV@kreacher> <800186a2-e912-3498-f08b-47469bbe8b0d@klausen.dk> <CAJZ5v0hfMS6aJP9G=dhZZ+3WTzM8=DzQkdJ7s9W3m5m9Dat5=g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, August 19, 2019 9:59:02 AM CEST Rafael J. Wysocki wrote:
> On Fri, Aug 16, 2019 at 10:26 PM Kristian Klausen <kristian@klausen.dk> wrote:
> >
> > On 02.08.2019 12.33, Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > >>> On top of the "Simplify the suspend-to-idle control flow" patch series
> > >>> posted previously:
> > >>>
> > >>> https://lore.kernel.org/lkml/71085220.z6FKkvYQPX@kreacher/
> > >>>
> > >>> sanitize the suspend-to-idle flow even further.
> > >>>
> > >>> First off, decouple EC wakeup from the LPS0 _DSM processing (patch 1).
> > >>>
> > >>> Next, reorder the code to invoke LPS0 _DSM Functions 5 and 6 in the
> > >>> specification-compliant order with respect to suspending and resuming
> > >>> devices (patch 2).
> > >>>
> > >>> Finally, rearrange lps0_device_attach() (patch 3) and add a command line
> > >>> switch to prevent the LPS0 _DSM from being used.
> > >> The v2 is because I found a (minor) bug in patch 1, decided to use a module
> > >> parameter instead of a kernel command line option in patch 4.  Also, there
> > >> are 4 new patches:
> > >>
> > >> Patch 5: Switch the EC over to polling during "noirq" suspend and back
> > >> during "noirq" resume.
> > >>
> > >> Patch 6: Eliminate acpi_sleep_no_ec_events().
> > >>
> > >> Patch 7: Consolidate some EC code depending on PM_SLEEP.
> > >>
> > >> Patch 8: Add EC GPE dispatching debug message.
> > > The v3 is just a rearranged v2 so as to move the post sensitive patch (previous patch 2)
> > > to the end of the series.   [After applying the full series the code is the same as before.]
> > >
> > > For easier testing, the series (along with some previous patches depended on by it)
> > > is available in the pm-s2idle-testing branch of the linux-pm.git tree at kernel.org:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=pm-s2idle-testing
> > It was just testing this patch series(461fc1caed55), to see if it would
> > fix my charging issue
> > (https://bugzilla.kernel.org/show_bug.cgi?id=201307), which it didn't.
> 
> It is unlikely to help in that case.
> 
> > I did however notice that my laptop (ASUS Zenbook UX430UNR/i7-8550U)
> > won't wake when opening the lid or pressing a key, the only way to wake
> > the laptop is pressing the power button.
> >
> > I also tested mainline (5.3.0-rc4 b7e7c85dc7b0) and 5.2.8 and the laptop
> > wakes without issue when the lid is opened or a key is presed.
> > > Please refer to the changelogs for details.
> 
> Thanks for your report.
> 
> I seem to see a similar issue with respect to the lid on one of my
> test machines, looking into it right now.

Well, my lid issue seems to be unrelated as it doesn't result from any patches in the
series in question.

First off, please clone 5.3-rc5 from kernel.org and double check if the issue is not
present in that one.

If that's not the case, merge the pm-s2idle-rework branch from my tree on top of it
and retest.

If you still see the issue then, apply the appended patch (on top of the pm-s2idle-reqork
branch ) and, after starting the kernel, do

# echo 1 > /sys/power/pm_debug_messages

suspend the system and try to wake it up through all of the ways that stopped working.

Then, wake it up with the power button, save the output of dmesg and send it to me.

Thanks!

---
 drivers/acpi/sleep.c        |    4 ++--
 drivers/base/power/wakeup.c |    2 ++
 kernel/irq/pm.c             |    2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -1012,9 +1012,9 @@ static void acpi_s2idle_wake(void)
 		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
 		acpi_ec_flush_work();
 		acpi_os_wait_events_complete(); /* synchronize Notify handling */
-	}
 
-	rearm_wake_irq(acpi_sci_irq);
+		rearm_wake_irq(acpi_sci_irq);
+	}
 }
 
 static void acpi_s2idle_restore_early(void)
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -871,6 +871,8 @@ void pm_wakeup_clear(bool reset)
 
 void pm_system_irq_wakeup(unsigned int irq_number)
 {
+	pm_pr_dbg("IRQ wakeup: IRQ %u\n", irq_number);
+
 	if (pm_wakeup_irq == 0) {
 		pm_wakeup_irq = irq_number;
 		pm_system_wakeup();
Index: linux-pm/kernel/irq/pm.c
===================================================================
--- linux-pm.orig/kernel/irq/pm.c
+++ linux-pm/kernel/irq/pm.c
@@ -15,6 +15,8 @@
 
 bool irq_pm_check_wakeup(struct irq_desc *desc)
 {
+	pm_pr_dbg("%s: IRQ %u\n", __func__, irq_desc_get_irq(desc));
+
 	if (irqd_is_wakeup_armed(&desc->irq_data)) {
 		irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
 		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;





