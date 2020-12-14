Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2D2D981B
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 13:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407388AbgLNMkO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 07:40:14 -0500
Received: from foss.arm.com ([217.140.110.172]:46738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406789AbgLNMj5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Dec 2020 07:39:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E4011B3;
        Mon, 14 Dec 2020 04:39:11 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54F323F66B;
        Mon, 14 Dec 2020 04:39:10 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     yousaf.kaukab@suse.com, jeremy.linton@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 2/4] cppc_cpufreq: clarify support for coordination types
Date:   Mon, 14 Dec 2020 12:38:21 +0000
Message-Id: <20201214123823.3949-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20201214123823.3949-1-ionela.voinescu@arm.com>
References: <20201214123823.3949-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The previous coordination type handling in the cppc_cpufreq init code
created some confusion: the comment mentioned "Support only SW_ANY for
now" while only the SW_ALL/ALL case resulted in a failure. The other
coordination types (HW_ALL/HW, NONE) were silently supported.

Clarify support for coordination types while describing in comments the
intended behavior.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 2700fc71d4e8..f15a44c8b6b7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -244,7 +244,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	unsigned int cpu = policy->cpu;
-	int ret = 0;
+	int i, ret = 0;
 
 	cpu_data->cpu = cpu;
 	ret = cppc_get_perf_caps(cpu, caps);
@@ -281,9 +281,13 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
 
-	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
-		int i;
-
+	switch (policy->shared_type) {
+	case CPUFREQ_SHARED_TYPE_HW:
+	case CPUFREQ_SHARED_TYPE_NONE:
+		/* Nothing to be done - we'll have a policy for each CPU */
+		break;
+	case CPUFREQ_SHARED_TYPE_ANY:
+		 /* All CPUs in the domain will share a policy */
 		cpumask_copy(policy->cpus, cpu_data->shared_cpu_map);
 
 		for_each_cpu(i, policy->cpus) {
@@ -293,9 +297,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			memcpy(&all_cpu_data[i]->perf_caps, caps,
 			       sizeof(cpu_data->perf_caps));
 		}
-	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
-		/* Support only SW_ANY for now. */
-		pr_debug("Unsupported CPU co-ord type\n");
+		break;
+	default:
+		pr_debug("Unsupported CPU co-ord type: %d\n",
+			 policy->shared_type);
 		return -EFAULT;
 	}
 
-- 
2.29.2.dirty

