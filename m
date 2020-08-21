Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49724DEB4
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Aug 2020 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHURlI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 13:41:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41928 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHURlE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2020 13:41:04 -0400
Received: from 89-64-88-37.dynamic.chello.pl (89.64.88.37) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 84c0e64bc6fbadae; Fri, 21 Aug 2020 19:41:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: sleep: core: Fix the handling of pending runtime resume requests
Date:   Fri, 21 Aug 2020 19:41:02 +0200
Message-ID: <7969920.MVx1BpXlEM@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It has been reported that system-wide suspend may be aborted in the
absence of any wakeup events due to unforseen interactions of it with
the runtume PM framework.

One failing scenario is when there are multiple devices sharing an
ACPI power resource and runtime-resume needs to be carried out for
one of them during system-wide suspend (for example, because it needs
to be reconfigured before the whole system goes to sleep).  In that
case, the runtime-resume of that device involves turning the ACPI
power resource "on" which in turn causes runtime resume requests
to be queued up for all of the other devices sharing it.  Those
requests go to the runtime PM workqueue which is frozen during
system-wide suspend, so they are not actually taken care of until
the resume of the whole system, but the pm_runtime_barrier()
call in __device_suspend() sees them and triggers system wakeup
events for them which then cause the system-wide suspend to be
aborted if wakeup source objects are in active use.

Of course, the logic that leads to triggering those wakeup events is
questionable in the first place, because clearly there are cases in
which a pending runtime resume request for a device is not connected
to any real wakeup events in any way (like the one above).  Moreover,
if there is a pending runtime resume request for a device while
__device_suspend() is running for it, the physical state of the
device may not be in agreement with the "suspended" runtime PM status
of it (which may be the very reason for queuing up the runtime resume
request for it).

For these reasons, rework __device_suspend() to carry out synchronous
runtime-resume for devices with pending runtime resume requests before
attempting to invoke system-wide suspend callbacks for them with the
expectation that their drivers will trigger system-wide wakeup events
in the process of handling the runtime resume, if necessary.

Fixes: 1e2ef05bb8cf8 ("PM: Limit race conditions between runtime PM and system sleep (v2)")
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1606,13 +1606,13 @@ static int __device_suspend(struct devic
 	}
 
 	/*
-	 * If a device configured to wake up the system from sleep states
-	 * has been suspended at run time and there's a resume request pending
-	 * for it, this is equivalent to the device signaling wakeup, so the
-	 * system suspend operation should be aborted.
+	 * If there's a runtime resume request pending for the device, resume
+	 * it before proceeding with invoking the system-wide suspend callbacks
+	 * for it, because the physical state of the device may not reflect the
+	 * "suspended" runtime PM status already in that case.
 	 */
-	if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
-		pm_wakeup_event(dev, 0);
+	if (pm_runtime_barrier(dev))
+		pm_runtime_resume(dev);
 
 	if (pm_wakeup_pending()) {
 		dev->power.direct_complete = false;



