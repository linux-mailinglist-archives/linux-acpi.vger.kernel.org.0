Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A6D7DE9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfJORfW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 13:35:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42382 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfJORfW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2019 13:35:22 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 8d7bb3b42b8b2d72; Tue, 15 Oct 2019 19:35:20 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] ACPI: processor: Avoid NULL pointer dereferences at init time
Date:   Tue, 15 Oct 2019 19:35:20 +0200
Message-ID: <9765491.cFa8AugBjT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If there are neither processor objects nor processor device objects
in the ACPI tables, the per-CPU processors table will not be
initialized and attempting to dereference pointers from there will
cause the kernel to crash.  This happens in acpi_processor_ppc_init()
and acpi_thermal_cpufreq_init() after commit d15ce412737a ("ACPI:
cpufreq: Switch to QoS requests instead of cpufreq notifier")
which didn't add the requisite NULL pointer checks in there.

Add the NULL pointer checks to acpi_processor_ppc_init() and
acpi_thermal_cpufreq_init(), and to the corresponding "exit"
routines.

While at it, drop redundant return instructions from
acpi_processor_ppc_init() and acpi_thermal_cpufreq_init().

Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c |   10 ++++++----
 drivers/acpi/processor_thermal.c |   10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -162,21 +162,23 @@ void acpi_processor_ppc_init(int cpu)
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 	int ret;
 
+	if (!pr)
+		return;
+
 	ret = dev_pm_qos_add_request(get_cpu_device(cpu),
 				     &pr->perflib_req, DEV_PM_QOS_MAX_FREQUENCY,
 				     INT_MAX);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
 		       ret);
-		return;
-	}
 }
 
 void acpi_processor_ppc_exit(int cpu)
 {
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
-	dev_pm_qos_remove_request(&pr->perflib_req);
+	if (pr)
+		dev_pm_qos_remove_request(&pr->perflib_req);
 }
 
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
Index: linux-pm/drivers/acpi/processor_thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_thermal.c
+++ linux-pm/drivers/acpi/processor_thermal.c
@@ -130,21 +130,23 @@ void acpi_thermal_cpufreq_init(int cpu)
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 	int ret;
 
+	if (!pr)
+		return;
+
 	ret = dev_pm_qos_add_request(get_cpu_device(cpu),
 				     &pr->thermal_req, DEV_PM_QOS_MAX_FREQUENCY,
 				     INT_MAX);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
 		       ret);
-		return;
-	}
 }
 
 void acpi_thermal_cpufreq_exit(int cpu)
 {
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
-	dev_pm_qos_remove_request(&pr->thermal_req);
+	if (pr)
+		dev_pm_qos_remove_request(&pr->thermal_req);
 }
 #else				/* ! CONFIG_CPU_FREQ */
 static int cpufreq_get_max_state(unsigned int cpu)



