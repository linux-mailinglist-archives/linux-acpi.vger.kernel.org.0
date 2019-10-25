Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E570E40A7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 02:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbfJYAlo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 20:41:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65441 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfJYAlo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 20:41:44 -0400
Received: from 79.184.254.57.ipv4.supernova.orange.pl (79.184.254.57) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 3d5b083a06540a5e; Fri, 25 Oct 2019 02:41:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: processor: Add QoS requests for all CPUs
Date:   Fri, 25 Oct 2019 02:41:40 +0200
Message-ID: <2435090.1mJ0fSsrDY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The _PPC change notifications from the platform firmware are per-CPU,
so acpi_processor_ppc_init() needs to add a frequency QoS request
for each CPU covered by a cpufreq policy to take all of them into
account.

Even though ACPI thermal control of CPUs sets frequency limits
per processor package, it also needs a frequency QoS request for each
CPU in a cpufreq policy in case some of them are taken offline and
the frequency limit needs to be set through the remaining online
ones (this is slightly excessive, because all CPUs covered by one
cpufreq policy will set the same frequency limit through their QoS
requests, but it is not incorrect).

Modify the code in accordance with the above observations.

Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c |   38 +++++++++++++++++++++++---------------
 drivers/acpi/processor_thermal.c |   38 +++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/acpi/processor_thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_thermal.c
+++ linux-pm/drivers/acpi/processor_thermal.c
@@ -127,26 +127,34 @@ static int cpufreq_set_cur_state(unsigne
 
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int cpu = policy->cpu;
-	struct acpi_processor *pr = per_cpu(processors, cpu);
-	int ret;
-
-	if (!pr)
-		return;
-
-	ret = freq_qos_add_request(&policy->constraints, &pr->thermal_req,
-				   FREQ_QOS_MAX, INT_MAX);
-	if (ret < 0)
-		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
-		       ret);
+	unsigned int cpu;
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		struct acpi_processor *pr = per_cpu(processors, cpu);
+		int ret;
+
+		if (!pr)
+			continue;
+
+		ret = freq_qos_add_request(&policy->constraints,
+					   &pr->thermal_req,
+					   FREQ_QOS_MAX, INT_MAX);
+		if (ret < 0)
+			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
+			       cpu, ret);
+	}
 }
 
 void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
-	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
+	unsigned int cpu;
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		struct acpi_processor *pr = per_cpu(processors, policy->cpu);
 
-	if (pr)
-		freq_qos_remove_request(&pr->thermal_req);
+		if (pr)
+			freq_qos_remove_request(&pr->thermal_req);
+	}
 }
 #else				/* ! CONFIG_CPU_FREQ */
 static int cpufreq_get_max_state(unsigned int cpu)
Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -159,26 +159,34 @@ void acpi_processor_ignore_ppc_init(void
 
 void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 {
-	int cpu = policy->cpu;
-	struct acpi_processor *pr = per_cpu(processors, cpu);
-	int ret;
-
-	if (!pr)
-		return;
-
-	ret = freq_qos_add_request(&policy->constraints, &pr->perflib_req,
-				   FREQ_QOS_MAX, INT_MAX);
-	if (ret < 0)
-		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
-		       ret);
+	unsigned int cpu;
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		struct acpi_processor *pr = per_cpu(processors, cpu);
+		int ret;
+
+		if (!pr)
+			continue;
+
+		ret = freq_qos_add_request(&policy->constraints,
+					   &pr->perflib_req,
+					   FREQ_QOS_MAX, INT_MAX);
+		if (ret < 0)
+			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
+			       cpu, ret);
+	}
 }
 
 void acpi_processor_ppc_exit(struct cpufreq_policy *policy)
 {
-	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
+	unsigned int cpu;
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		struct acpi_processor *pr = per_cpu(processors, cpu);
 
-	if (pr)
-		freq_qos_remove_request(&pr->perflib_req);
+		if (pr)
+			freq_qos_remove_request(&pr->perflib_req);
+	}
 }
 
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)



