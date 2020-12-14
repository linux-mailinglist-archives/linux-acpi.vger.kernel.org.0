Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DB02D981A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 13:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407316AbgLNMkI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 07:40:08 -0500
Received: from foss.arm.com ([217.140.110.172]:46750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407235AbgLNMkA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Dec 2020 07:40:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC63C11FB;
        Mon, 14 Dec 2020 04:39:14 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AACB3F66B;
        Mon, 14 Dec 2020 04:39:13 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     yousaf.kaukab@suse.com, jeremy.linton@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 3/4] cppc_cpufreq: expose information on frequency domains
Date:   Mon, 14 Dec 2020 12:38:22 +0000
Message-Id: <20201214123823.3949-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20201214123823.3949-1-ionela.voinescu@arm.com>
References: <20201214123823.3949-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use the existing sysfs attribute "freqdomain_cpus" to expose
information to userspace about CPUs in the same frequency domain.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  3 ++-
 drivers/cpufreq/cppc_cpufreq.c                     | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1a04ca8162ad..0eee30b27ab6 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -264,7 +264,8 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
 		attribute is useful for user space DVFS controllers to get better
 		power/performance results for platforms using acpi-cpufreq.
 
-		This file is only present if the acpi-cpufreq driver is in use.
+		This file is only present if the acpi-cpufreq or the cppc-cpufreq
+		drivers are in use.
 
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f15a44c8b6b7..40b58d2dbbc6 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -402,6 +402,19 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
+{
+	unsigned int cpu = policy->cpu;
+
+	return cpufreq_show_cpus(all_cpu_data[cpu]->shared_cpu_map, buf);
+}
+cpufreq_freq_attr_ro(freqdomain_cpus);
+
+static struct freq_attr *cppc_cpufreq_attr[] = {
+	&freqdomain_cpus,
+	NULL,
+};
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.verify = cppc_verify_policy,
@@ -410,6 +423,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.init = cppc_cpufreq_cpu_init,
 	.stop_cpu = cppc_cpufreq_stop_cpu,
 	.set_boost = cppc_cpufreq_set_boost,
+	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
 };
 
-- 
2.29.2.dirty

