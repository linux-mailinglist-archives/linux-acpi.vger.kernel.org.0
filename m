Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED059150519
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2020 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBCLT2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Feb 2020 06:19:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59102 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgBCLT2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Feb 2020 06:19:28 -0500
Received: from 79.184.253.222.ipv4.supernova.orange.pl (79.184.253.222) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 1b2d49228637a18f; Mon, 3 Feb 2020 12:19:26 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v2 1/2] intel_idle: Introduce 'use_acpi' module parameter
Date:   Mon, 03 Feb 2020 12:15:42 +0100
Message-ID: <2444753.PIBkttuji9@kreacher>
In-Reply-To: <1921392.EN65KG1giI@kreacher>
References: <1720216.0Jr2BLnqKp@kreacher> <1921392.EN65KG1giI@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For diagnostics, it is generally useful to be able to make intel_idle
take the system's ACPI tables into consideration even if that is not
required for the processor model in there, so introduce a new module
parameter, 'use_acpi', to make that happen and update the documentation
to cover it.

While at it, fix the 'no_acpi' module parameter name in the
documentation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
   * Fix build for CONFIG_ACPI unset.

---
 Documentation/admin-guide/pm/intel_idle.rst |   13 +++++++++----
 drivers/idle/intel_idle.c                   |   11 +++++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1131,6 +1131,10 @@ static bool no_acpi __read_mostly;
 module_param(no_acpi, bool, 0444);
 MODULE_PARM_DESC(no_acpi, "Do not use ACPI _CST for building the idle states list");
 
+static bool force_use_acpi __read_mostly; /* No effect if no_acpi is set. */
+module_param_named(use_acpi, force_use_acpi, bool, 0444);
+MODULE_PARM_DESC(use_acpi, "Use ACPI _CST for building the idle states list");
+
 static struct acpi_processor_power acpi_state_table __initdata;
 
 /**
@@ -1258,6 +1262,8 @@ static bool __init intel_idle_off_by_def
 	return true;
 }
 #else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
+#define force_use_acpi	(false)
+
 static inline bool intel_idle_acpi_cst_extract(void) { return false; }
 static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
 static inline bool intel_idle_off_by_default(u32 mwait_hint) { return false; }
@@ -1460,7 +1466,8 @@ static void __init intel_idle_init_cstat
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
-		if (icpu->use_acpi && intel_idle_off_by_default(mwait_hint) &&
+		if ((icpu->use_acpi || force_use_acpi) &&
+		    intel_idle_off_by_default(mwait_hint) &&
 		    !(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_ALWAYS_ENABLE))
 			drv->states[drv->state_count].flags |= CPUIDLE_FLAG_OFF;
 
@@ -1607,7 +1614,7 @@ static int __init intel_idle_init(void)
 	icpu = (const struct idle_cpu *)id->driver_data;
 	if (icpu) {
 		cpuidle_state_table = icpu->state_table;
-		if (icpu->use_acpi)
+		if (icpu->use_acpi || force_use_acpi)
 			intel_idle_acpi_cst_extract();
 	} else if (!intel_idle_acpi_cst_extract()) {
 		return -ENODEV;
Index: linux-pm/Documentation/admin-guide/pm/intel_idle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_idle.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_idle.rst
@@ -60,6 +60,9 @@ of the system.  The former are always us
 recognized by ``intel_idle`` and the latter are used if that is required for
 the given processor model (which is the case for all server processor models
 recognized by ``intel_idle``) or if the processor model is not recognized.
+[There is a module parameter that can be used to make the driver use the ACPI
+tables with any processor model recognized by it; see
+`below <intel-idle-parameters_>`_.]
 
 If the ACPI tables are going to be used for building the list of available idle
 states, ``intel_idle`` first looks for a ``_CST`` object under one of the ACPI
@@ -165,7 +168,7 @@ and ``idle=nomwait``.  If any of them is
 ``MWAIT`` instruction is not allowed to be used, so the initialization of
 ``intel_idle`` will fail.
 
-Apart from that there are two module parameters recognized by ``intel_idle``
+Apart from that there are three module parameters recognized by ``intel_idle``
 itself that can be set via the kernel command line (they cannot be updated via
 sysfs, so that is the only way to change their values).
 
@@ -186,9 +189,11 @@ QoS) feature can be used to prevent ``CP
 even if they have been enumerated (see :ref:`cpu-pm-qos` in :doc:`cpuidle`).
 Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to fail.
 
-The ``noacpi`` module parameter (which is recognized by ``intel_idle`` if the
-kernel has been configured with ACPI support), can be set to make the driver
-ignore the system's ACPI tables entirely (it is unset by default).
+The ``no_acpi`` and ``use_acpi`` module parameters (recognized by ``intel_idle``
+if the kernel has been configured with ACPI support) can be set to make the
+driver ignore the system's ACPI tables entirely or use them for all of the
+recognized processor models, respectively (they both are unset by default and
+``use_acpi`` has no effect if ``no_acpi`` is set).
 
 
 .. _intel-idle-core-and-package-idle-states:



