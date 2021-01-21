Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264BD2FDE31
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 01:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbhAUAwX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 19:52:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:54756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732716AbhAUAdw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Jan 2021 19:33:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8290FAD29;
        Thu, 21 Jan 2021 00:33:07 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] x86,sched: On AMD EPYC set freq_max = max_boost in schedutil invariant formula
Date:   Thu, 21 Jan 2021 01:32:23 +0100
Message-Id: <20210121003223.20257-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Phoronix.com discovered a severe performance regression on AMD APYC
introduced on schedutil [see link 1] by the following commits from v5.11-rc1

    commit 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
    commit 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")

Furthermore commit db865272d9c4 ("cpufreq: Avoid configuring old governors as
default with intel_pstate") from v5.10 made it extremely easy to default to
schedutil even if the preferred driver is acpi_cpufreq. Distros are likely to
build both intel_pstate and acpi_cpufreq on x86, and the presence of the
former removes ondemand from the defaults. This situation amplifies the
visibility of the bug we're addressing.

[link 1] https://www.phoronix.com/scan.php?page=article&item=linux511-amd-schedutil&num=1

1. PROBLEM DESCRIPTION   : over-utilization and schedutil
2. PROPOSED SOLUTION     : raise freq_max in schedutil formula
3. DATA TABLE            : image processing benchmark
4. ANALYSIS AND COMMENTS : with over-utilization, freq-invariance is lost

1. PROBLEM DESCRIPTION (over-utilization and schedutil)

The problem happens on CPU-bound workloads spanning a large number of cores.
In this case schedutil won't select the maximum P-State. Actually, it's
likely that it will select the minimum one.

A CPU-bound workload puts the machine in a state generally called
"over-utilization": an increase in CPU speed doesn't result in an increase of
capacity. The fraction of time tasks spend on CPU becomes constant regardless
of clock frequency (the tasks eat whatever we throw at them), and the PELT
invariant util goes up and down with the frequency (i.e. it's not invariant
anymore).

2. PROPOSED SOLUTION (raise freq_max in schedutil formula)

The solution we implement here is a stop-gap one: when the driver is
acpi_cpufreq and the machine an AMD EPYC, schedutil will use max_boost instead
of max_P as the value for freq_max in its formula

    freq_next = 1.25 * freq_max * util

essentially giving freq_next some more headroom to grow in the over-utilized
case. This is the approach also followed by intel_pstate in passive mode.

The correct way to attack this problem would be to have schedutil detect
over-utilization and select freq_max irrespective of the util value, which has
no meaning at that point. This approach is too risky for an -rc5 submission so
we defer it to the next cycle.

3. DATA TABLE (image processing benchmark)

What follow is a more detailed account of the effects on a specific test.

TEST        : Intel Open Image Denoise, www.openimagedenoise.org
INVOCATION  : ./denoise -hdr memorial.pfm -out out.pfm -bench 200 -threads $NTHREADS
CPU         : MODEL            : 2x AMD EPYC 7742
              FREQUENCY TABLE  : P2: 1.50 GHz
                                 P1: 2.00 GHz
				 P0: 2.25 GHz
              MAX BOOST        :     3.40 GHz

Results: threads, msecs (ratio). Lower is better.

               v5.10          v5.11-rc4    v5.11-rc4-patch
    -------------------------------------------------------
      1   1069.85 (1.00)   1071.84 (1.00)   1070.42 (1.00)
      2    542.24 (1.00)    544.40 (1.00)    544.48 (1.00)
      4    278.00 (1.00)    278.44 (1.00)    277.72 (1.00)
      8    149.81 (1.00)    149.61 (1.00)    149.87 (1.00)
     16     79.01 (1.00)     79.31 (1.00)     78.94 (1.00)
     24     58.01 (1.00)     58.51 (1.01)     58.15 (1.00)
     32     46.58 (1.00)     48.30 (1.04)     46.66 (1.00)
     48     37.29 (1.00)     51.29 (1.38)     37.27 (1.00)
     64     34.01 (1.00)     49.59 (1.46)     33.71 (0.99)
     80     31.09 (1.00)     44.27 (1.42)     31.33 (1.01)
     96     28.56 (1.00)     40.82 (1.43)     28.47 (1.00)
    112     28.09 (1.00)     40.06 (1.43)     28.63 (1.02)
    120     28.73 (1.00)     39.78 (1.38)     28.14 (0.98)
    128     28.93 (1.00)     39.60 (1.37)     29.38 (1.02)

See how the 128 threads case is almost 40% worse than baseline in v5.11-rc4.

4. ANALYSIS AND COMMENTS (with over-utilization freq-invariance is lost)

Statistics for NTHREADS=128 (number of physical cores of the machine)

                                      v5.10          v5.11-rc4
                                      ------------------------
CPU activity (mpstat)                 80-90%         80-90%
schedutil requests (tracepoint)       always P0      mostly P2
CPU frequency (HW feedback)           ~2.2 GHz       ~1.5 GHz
PELT root rq util (tracepoint)        ~825           ~450

mpstat shows that the workload is CPU-bound and usage doesn't change with
clock speed. What is striking is that the PELT util of any root runqueue in
v5.11-rc4 is half of what used to be before the frequency invariant support
(v5.10), leading to wrong frequency choices. How did we get there?

This workload is constant in time, so instead of using the PELT sum we can
pretend that scale invariance is obtained with

    util_inv = util_raw * freq_curr / freq_max1        [formula-1]

where util_raw is the PELT util from v5.10 (which is to say, not invariant),
and util_inv is the PELT util from v5.11-rc4. freq_max1 comes from
commit 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for
frequency invariance on AMD EPYC") and is (P0+max_boost)/2 = (2.25+3.4)/2 =
2.825 GHz.  Then we have the schedutil formula

    freq_next = 1.25 * freq_max2 * util_inv            [formula-2]

Here v5.11-rc4 uses freq_max2 = P0 = 2.25 GHz (and this patch changes it to
3.4 GHz).

Since all cores are busy, there is no boost available. Let's be generous and say
the tasks initially get P0, i.e. freq_curr = 2.25 GHz. Combining the formulas
above and taking util_raw = 825/1024 = 0.8, freq_next is:

    freq_next = 1.25 * 2.25 * 0.8 * 2.25 / 2.825 = 1.79 GHz

After quantization (pick the next frequency up in the table), freq_next is
P1 = 2.0 GHz. See how we lost 250 MHz in the process. Iterate once more,
freq_next become 1.59 GHz. Since it's > P2, it's saved by quantization and P1
is selected, but if util_raw fluctuates a little and goes below 0.75, P0 is
selected and that kills util_inv by formula-1, which gives util_inv = 0.4.

The culprit of the problem is that with over-utilization, util_raw and
freq_curr in formula-1 are independent. In the nominal case, if freq_curr goes
up then util_raw goes down and viceversa. Here util_raw doesn't care and stays
constant. If freq_curr descrease, util_inv decreases too and so forth (it's a
feedback loop).

Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
Fixes: 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/cpufreq/freq_table.c     | 51 ++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h          |  5 ++++
 kernel/sched/cpufreq_schedutil.c |  8 +++--
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index f839dc9852c0..f143c7db9d85 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -10,6 +10,10 @@
 #include <linux/cpufreq.h>
 #include <linux/module.h>
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+#endif
+
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
@@ -29,12 +33,53 @@ bool policy_has_boost_freq(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(policy_has_boost_freq);
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static bool amd_max_boost(unsigned int max_freq, unsigned int *max_boost)
+{
+	struct cppc_perf_caps perf_caps;
+	u64 highest_perf, nominal_perf, perf_ratio;
+	int ret;
+
+	ret = cppc_get_perf_caps(0, &perf_caps);
+	if (ret) {
+		pr_debug("Could not retrieve perf counters (%d)\n", ret);
+		return false;
+	}
+
+	highest_perf = perf_caps.highest_perf;
+	nominal_perf = perf_caps.nominal_perf;
+
+	if (!highest_perf || !nominal_perf) {
+		pr_debug("Could not retrieve highest or nominal performance\n");
+		return false;
+	}
+
+	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
+	if (perf_ratio <= SCHED_CAPACITY_SCALE) {
+		pr_debug("Either perf_ratio is 0, or nominal >= highest performance\n");
+		return false;
+	}
+
+	*max_boost = max_freq * perf_ratio >> SCHED_CAPACITY_SHIFT;
+
+	return true;
+}
+#else
+static int amd_max_boost(unsigned int max_freq, unsigned int *max_boost)
+{
+	return false;
+}
+#endif
+
+DEFINE_STATIC_KEY_FALSE(cpufreq_amd_max_boost);
+
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos;
 	unsigned int min_freq = ~0;
 	unsigned int max_freq = 0;
+	unsigned int max_boost;
 	unsigned int freq;
 
 	cpufreq_for_each_valid_entry(pos, table) {
@@ -54,6 +99,12 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 	policy->min = policy->cpuinfo.min_freq = min_freq;
 	policy->max = policy->cpuinfo.max_freq = max_freq;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    amd_max_boost(max_freq, &max_boost)) {
+		policy->cpuinfo.max_boost = max_boost;
+		static_branch_enable(&cpufreq_amd_max_boost);
+	}
+
 	if (policy->min == ~0)
 		return -EINVAL;
 	else
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9c8b7437b6cd..341cac76d254 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -40,9 +40,14 @@ enum cpufreq_table_sorting {
 	CPUFREQ_TABLE_SORTED_DESCENDING
 };
 
+DECLARE_STATIC_KEY_FALSE(cpufreq_amd_max_boost);
+
+#define cpufreq_driver_has_max_boost() static_branch_unlikely(&cpufreq_amd_max_boost)
+
 struct cpufreq_cpuinfo {
 	unsigned int		max_freq;
 	unsigned int		min_freq;
+	unsigned int		max_boost;
 
 	/* in 10^(-9) s = nanoseconds */
 	unsigned int		transition_latency;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 6931f0cdeb80..541f3db3f576 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -159,8 +159,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq, max_freq;
+
+	max_freq = cpufreq_driver_has_max_boost() ?
+			policy->cpuinfo.max_boost : policy->cpuinfo.max_freq;
+
+	freq = arch_scale_freq_invariant() ? max_freq : policy->cur;
 
 	freq = map_util_freq(util, freq, max);
 
-- 
2.26.2

