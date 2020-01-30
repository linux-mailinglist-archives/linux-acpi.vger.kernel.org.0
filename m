Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E845714DD1A
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2020 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgA3Ork (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jan 2020 09:47:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53773 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgA3Orj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jan 2020 09:47:39 -0500
Received: from 79.184.253.19.ipv4.supernova.orange.pl (79.184.253.19) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id cb4c27334bb16a9a; Thu, 30 Jan 2020 15:47:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] intel_idle: Introduce 'states_off' module parameter
Date:   Thu, 30 Jan 2020 15:47:24 +0100
Message-ID: <16995896.bQtfYxEEOs@kreacher>
In-Reply-To: <1720216.0Jr2BLnqKp@kreacher>
References: <1720216.0Jr2BLnqKp@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In certain system configurations it may not be desirable to use some
C-states assumed to be available by intel_idle and the driver needs
to be prevented from using them even before the cpuidle sysfs
interface becomes accessible to user space.  Currently, the only way
to achieve that is by setting the 'max_cstate' module parameter to a
value lower than the index of the shallowest of the C-states in
question, but that may be overly intrusive, because it effectively
makes all of the idle states deeper than the 'max_cstate' one go
away (and the C-state to avoid may be in the middle of the range
normally regarded as available).

To allow that limitation to be overcome, introduce a new module
parameter called 'states_off' to represent a list of idle states to
be disabled by default in the form of a bitmask and update the
documentation to cover it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_idle.rst |   15 ++++++++++++++-
 drivers/idle/intel_idle.c                   |   24 +++++++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -63,6 +63,7 @@ static struct cpuidle_driver intel_idle_
 };
 /* intel_idle.max_cstate=0 disables driver */
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
+static unsigned int disabled_states_mask;
 
 static unsigned int mwait_substates;
 
@@ -1234,6 +1235,9 @@ static void __init intel_idle_init_cstat
 		if (cx->type > ACPI_STATE_C2)
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
 
+		if (disabled_states_mask & BIT(cstate))
+			state->flags |= CPUIDLE_FLAG_OFF;
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
@@ -1466,9 +1470,10 @@ static void __init intel_idle_init_cstat
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
-		if ((icpu->use_acpi || use_acpi) &&
-		    intel_idle_off_by_default(mwait_hint) &&
-		    !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE))
+		if ((disabled_states_mask & BIT(drv->state_count)) ||
+		    ((icpu->use_acpi || use_acpi) &&
+		     intel_idle_off_by_default(mwait_hint) &&
+		     !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
 			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
 
 		drv->state_count++;
@@ -1487,6 +1492,10 @@ static void __init intel_idle_init_cstat
 static void __init intel_idle_cpuidle_driver_init(struct cpuidle_driver *drv)
 {
 	cpuidle_poll_state_init(drv);
+
+	if (disabled_states_mask & BIT(0))
+		drv->states[0].flags |= CPUIDLE_FLAG_OFF;
+
 	drv->state_count = 1;
 
 	if (icpu)
@@ -1667,3 +1676,12 @@ device_initcall(intel_idle_init);
  * is the easiest way (currently) to continue doing that.
  */
 module_param(max_cstate, int, 0444);
+/*
+ * The positions of the bits that are set in the two's complement representation
+ * of this value are the indices of the idle states to be disabled by default
+ * (as reflected by the names of the corresponding idle state directories in
+ * sysfs, "state0", "state1" ... "state<i>" ..., where <i> is the index of the
+ * given state).
+ */
+module_param_named(states_off, disabled_states_mask, uint, 0444);
+MODULE_PARM_DESC(states_off, "Mask of disabled idle states");
Index: linux-pm/Documentation/admin-guide/pm/intel_idle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_idle.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_idle.rst
@@ -168,7 +168,7 @@ and ``idle=nomwait``.  If any of them is
 ``MWAIT`` instruction is not allowed to be used, so the initialization of
 ``intel_idle`` will fail.
 
-Apart from that there are three module parameters recognized by ``intel_idle``
+Apart from that there are four module parameters recognized by ``intel_idle``
 itself that can be set via the kernel command line (they cannot be updated via
 sysfs, so that is the only way to change their values).
 
@@ -195,6 +195,19 @@ driver ignore the system's ACPI tables e
 recognized processor models, respectively (they both are unset by default and
 ``use_acpi`` has no effect if ``no_acpi`` is set).
 
+The value of the ``states_off`` module parameter (0 by default) represents a
+list of idle states to be disabled by default in the form of a bitmask.  Namely,
+the positions of the bits that are set in the two's complement representation of
+that value are the indices of idle states to be disabled by default (as
+reflected by the names of the corresponding idle state directories in ``sysfs``,
+:file:`state0`, :file:`state1` ... :file:`state<i>` ..., where ``<i>`` is the
+index of the given idle state; see :ref:`idle-states-representation` in
+:doc:`cpuidle`).  For example, if ``states_off`` is equal to 3, the driver will
+disable idle states 0 and 1 by default, and if it is equal to 8, idle state 3
+will be disabled by default and so on (bit positions beyond the maximum idle
+state index are ignored).  The idle states disabled this way can be enabled (on
+a per-CPU basis) from user space via ``sysfs``.
+
 
 .. _intel-idle-core-and-package-idle-states:
 



