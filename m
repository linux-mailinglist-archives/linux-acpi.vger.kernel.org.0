Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A94166C13
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2020 01:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgBUAqW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Feb 2020 19:46:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61269 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgBUAqW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Feb 2020 19:46:22 -0500
Received: from 79.184.254.252.ipv4.supernova.orange.pl (79.184.254.252) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 7483224b3d42fef3; Fri, 21 Feb 2020 01:46:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: Linux 5.6-rc2
Date:   Fri, 21 Feb 2020 01:46:18 +0100
Message-ID: <4974198.mf5Me8BlfX@kreacher>
In-Reply-To: <10791544.HYfhKnFLvn@kreacher>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com> <158197497594.2449.9692451182044632969@skylake-alporthouse-com> <10791544.HYfhKnFLvn@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, February 20, 2020 11:41:22 PM CET Rafael J. Wysocki wrote:
> On Monday, February 17, 2020 10:29:35 PM CET Chris Wilson wrote:
> > Quoting Linus Torvalds (2020-02-17 21:20:27)
> > > On Mon, Feb 17, 2020 at 8:22 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > > >
> > > > Quoting Linus Torvalds (2020-02-16 21:32:32)
> > > > > Rafael J. Wysocki (4):
> > > > >       ACPI: EC: Fix flushing of pending work
> > > > >       ACPI: PM: s2idle: Avoid possible race related to the EC GPE
> > > > >       ACPICA: Introduce acpi_any_gpe_status_set()
> > > > >       ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
> > > >
> > > > Our S0 testing broke on all platforms, so we've reverted
> > > > e3728b50cd9b ("ACPI: PM: s2idle: Avoid possible race related to the EC GPE")
> > > > fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> > > >
> > > > There wasn't much in the logs, for example,
> > > > https://intel-gfx-ci.01.org/tree/drm-tip/IGT_5445/fi-kbl-7500u/igt@gem_exec_suspend@basic-s0.html
> > > 
> > > So the machine suspends, but never comes back?
> > > 
> > > Do you need to revert both for it to work for you? Or is the revert of
> > > fdde0ff8590b just to avoid the conflict?
> > 
> > fdde0ff85 was just to avoid conflicts.
> >  
> > > I'm assuming you bisected this, and the bisect indicated e3728b50cd9b,
> > > and then to revert it you reverted the other commit too..
> > 
> > Lucky guess based on diff rc1..rc2. Bisect was going to be painful, but
> > could be done if this is not enough clue for Rafael.
> 
> Sorry for the delayed response, was away.
> 
> I'm guessing that you are using rtcwake for wakeup, in which case reverting
> fdde0ff85 alone should unbreak it.
> 
> Can you please double check that?

And below is a patch that should fix it if I'm not mistaken (verified on my
system where I was able to reproduce the issue), so it would suffice to test
this one on top of the -rc2.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: PM: s2idle: Check fixed wakeup events in acpi_s2idle_wake()

Commit fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from
waking up the system") overlooked the fact that fixed events can wake
up the system too and broke RTC wakeup from suspend-to-idle as a
result.

Fix this issue by checking the fixed events in acpi_s2idle_wake() in
addition to checking wakeup GPEs and break out of the suspend-to-idle
loop if the status bits of any enabled fixed events are set then.

Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evevent.c |   45 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c          |    7 ++++++
 include/acpi/acpixf.h         |    1 
 3 files changed, 53 insertions(+)

Index: linux-pm/drivers/acpi/acpica/evevent.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evevent.c
+++ linux-pm/drivers/acpi/acpica/evevent.c
@@ -265,4 +265,49 @@ static u32 acpi_ev_fixed_event_dispatch(
 		 handler) (acpi_gbl_fixed_event_handlers[event].context));
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_any_fixed_event_status_set
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      TRUE or FALSE
+ *
+ * DESCRIPTION: Checks the PM status register for active fixed events
+ *
+ ******************************************************************************/
+
+u32 acpi_any_fixed_event_status_set(void)
+{
+	acpi_status status;
+	u32 in_status;
+	u32 in_enable;
+	u32 i;
+
+	status = acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &in_enable);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	status = acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &in_status);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	/*
+	 * Check for all possible Fixed Events and dispatch those that are active
+	 */
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
+
+		/* Both the status and enable bits must be on for this event */
+
+		if ((in_status & acpi_gbl_fixed_event_info[i].status_bit_mask) &&
+		    (in_enable & acpi_gbl_fixed_event_info[i].enable_bit_mask)) {
+			return (TRUE);
+		}
+	}
+
+	return (FALSE);
+}
+
 #endif				/* !ACPI_REDUCED_HARDWARE */
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -753,6 +753,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_gpe_status_set(void))
+ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_fixed_event_status_set(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_gpe_device(u32 gpe_index,
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -1006,6 +1006,13 @@ static bool acpi_s2idle_wake(void)
 			return true;
 
 		/*
+		 * If the status bit of any enabled fixed event is set, the
+		 * wakeup is regarded as valid.
+		 */
+		if (acpi_any_fixed_event_status_set())
+			return true;
+
+		/*
 		 * If there are no EC events to process and at least one of the
 		 * other enabled GPEs is active, the wakeup is regarded as a
 		 * genuine one.



