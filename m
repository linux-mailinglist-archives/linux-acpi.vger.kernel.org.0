Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D912D2D9824
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395114AbgLNMj5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 07:39:57 -0500
Received: from foss.arm.com ([217.140.110.172]:46724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405045AbgLNMjy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Dec 2020 07:39:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BE01042;
        Mon, 14 Dec 2020 04:39:08 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 142A13F66B;
        Mon, 14 Dec 2020 04:39:06 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     yousaf.kaukab@suse.com, jeremy.linton@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 1/4] cppc_cpufreq: use policy->cpu as driver of frequency setting
Date:   Mon, 14 Dec 2020 12:38:20 +0000
Message-Id: <20201214123823.3949-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20201214123823.3949-1-ionela.voinescu@arm.com>
References: <20201214123823.3949-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Considering only the currently supported coordination types (ANY, HW,
NONE), this change only makes a difference for the ANY type, when
policy->cpu is hotplugged out. In that case the new policy->cpu will
be different from ((struct cppc_cpudata *)policy->driver_data)->cpu.

While in this case the controls of *ANY* CPU could be used to drive
frequency changes, it's more consistent to use policy->cpu as the
leading CPU, as used in all other cppc_cpufreq functions. Additionally,
the debug prints in cppc_set_perf() would no longer create confusion
when referring to a CPU that is hotplugged out.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7cc9bd8568de..2700fc71d4e8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -150,6 +150,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int relation)
 {
 	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	unsigned int cpu = policy->cpu;
 	struct cpufreq_freqs freqs;
 	u32 desired_perf;
 	int ret = 0;
@@ -164,12 +165,12 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu_data->cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
 	if (ret)
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
-			 cpu_data->cpu, ret);
+			 cpu, ret);
 
 	return ret;
 }
-- 
2.29.2.dirty

