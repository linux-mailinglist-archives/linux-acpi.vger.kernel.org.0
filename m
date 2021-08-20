Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF443F245E
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 03:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhHTBb7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 21:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhHTBb6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2021 21:31:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF5C061575;
        Thu, 19 Aug 2021 18:31:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c4so5030568plh.7;
        Thu, 19 Aug 2021 18:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/YLCtZuePBllw/Zn57jUmVpm/kBwVZsI4ug8E6fHEc=;
        b=ZPxHakUkPM8rDynwTYFDsZMAjJLElGaqdGN2YpBWnB/JSrP3LyfYG7BGWmXFW+D2//
         ZaI+oKs3jA2JP2coRwBePOhzGgbZFmorZeHIHwzaqOvlRxKxP6JMcFf/HwuuXAHJoN99
         vI87vYw/DEz/QW6yo+Sn7G0FrfyBdYSB3GabtLoQA875ve/LEx6BqZ6Tec4u33kXzPOr
         3+B19gKdVduTCuMFFshgU2pr+l7SZVlLww0g/RpmJJEsxBHHYainB1xFPcxYE0rnyJDr
         D5d/MZIxmKeX65OoIEbkBQqiCpwTUuQDtNCBLmCnh3yPkij1/jzTi5hatp34ouR/hERJ
         K2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/YLCtZuePBllw/Zn57jUmVpm/kBwVZsI4ug8E6fHEc=;
        b=YqHhcQx+d+DE5BNWUAuhC6qbqQfVn7+JWdI50r7UspUdgNmQYsIKVgCw+OtbWlQ/Fk
         VbyVksSrB169Hsa5Oru6wJiEaZJTYpqzG2+EhE/teAd03qYkJthDdc9cysjvSCsLZFqy
         Z51b6kIsGavEsusHIMsWYLtvsrCCfX3Wwm9AifzxCajkhoat9UZxLATVTnErBbpzVWju
         jX26KOfA3jRY+ib2TtHjxTIKZ6sqTJ/zQki08hY0Dgnf7eXItgEw4ewjeQKYMOh1BFMl
         hi4+T0UGjFjLMCZg1+ES1fbysApmT0qxxCSkD8dTr1wu7qZRDmTsXt90aiKCsXhUl2mB
         B0LA==
X-Gm-Message-State: AOAM532iPnH0CiTZ0vQKQaJecC8DJ+XIzZ4gg+OONj9cSoCazoLAk0RV
        uHuPCBRykBbS+lFptiIgyIc=
X-Google-Smtp-Source: ABdhPJwMz0oSiOq8GXMZCOfvuYBNDZrc8o1nOqberFkN1RdmqXUnYmuWRAiD8qgprbkRRhozTR+iQA==
X-Received: by 2002:a17:90a:b303:: with SMTP id d3mr1834235pjr.199.1629423080845;
        Thu, 19 Aug 2021 18:31:20 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:d23:7118:c805:b5a5])
        by smtp.gmail.com with ESMTPSA id 66sm4877950pfu.67.2021.08.19.18.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 18:31:20 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bp@alien8.de, catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, juri.lelli@redhat.com,
        bristot@redhat.com, lenb@kernel.org, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net,
        sudeep.holla@arm.com, tglx@linutronix.de
Cc:     aubrey.li@linux.intel.com, bsegall@google.com,
        guodong.xu@linaro.org, jonathan.cameron@huawei.com,
        liguozhu@hisilicon.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rostedt@goodmis.org,
        tim.c.chen@linux.intel.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, will@kernel.org, x86@kernel.org,
        xuwei5@huawei.com, yangyicong@huawei.com, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: [PATCH 2/3] scheduler: Add cluster scheduler level in core and related Kconfig for ARM64
Date:   Fri, 20 Aug 2021 13:30:07 +1200
Message-Id: <20210820013008.12881-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820013008.12881-1-21cnbao@gmail.com>
References: <20210820013008.12881-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

This patch adds scheduler level for clusters and automatically enables
the load balance among clusters. It will directly benefit a lot of
workload which loves more resources such as memory bandwidth, caches.

Testing has widely been done in two different hardware configurations of
Kunpeng920:

 24 cores in one NUMA(6 clusters in each NUMA node);
 32 cores in one NUMA(8 clusters in each NUMA node)

Workload is running on either one NUMA node or four NUMA nodes, thus,
this can estimate the effect of cluster spreading w/ and w/o NUMA load
balance.

* Stream benchmark:

4threads stream (on 1NUMA * 24cores = 24cores)
                stream                 stream
                w/o patch              w/ patch
MB/sec copy     29929.64 (   0.00%)    32932.68 (  10.03%)
MB/sec scale    29861.10 (   0.00%)    32710.58 (   9.54%)
MB/sec add      27034.42 (   0.00%)    32400.68 (  19.85%)
MB/sec triad    27225.26 (   0.00%)    31965.36 (  17.41%)

6threads stream (on 1NUMA * 24cores = 24cores)
                stream                 stream
                w/o patch              w/ patch
MB/sec copy     40330.24 (   0.00%)    42377.68 (   5.08%)
MB/sec scale    40196.42 (   0.00%)    42197.90 (   4.98%)
MB/sec add      37427.00 (   0.00%)    41960.78 (  12.11%)
MB/sec triad    37841.36 (   0.00%)    42513.64 (  12.35%)

12threads stream (on 1NUMA * 24cores = 24cores)
                stream                 stream
                w/o patch              w/ patch
MB/sec copy     52639.82 (   0.00%)    53818.04 (   2.24%)
MB/sec scale    52350.30 (   0.00%)    53253.38 (   1.73%)
MB/sec add      53607.68 (   0.00%)    55198.82 (   2.97%)
MB/sec triad    54776.66 (   0.00%)    56360.40 (   2.89%)

Thus, it could help memory-bound workload especially under medium load.
Similar improvement is also seen in lkp-pbzip2:

* lkp-pbzip2 benchmark

2-96 threads (on 4NUMA * 24cores = 96cores)
                  lkp-pbzip2              lkp-pbzip2
                  w/o patch               w/ patch
Hmean     tput-2   11062841.57 (   0.00%)  11341817.51 *   2.52%*
Hmean     tput-5   26815503.70 (   0.00%)  27412872.65 *   2.23%*
Hmean     tput-8   41873782.21 (   0.00%)  43326212.92 *   3.47%*
Hmean     tput-12  61875980.48 (   0.00%)  64578337.51 *   4.37%*
Hmean     tput-21 105814963.07 (   0.00%) 111381851.01 *   5.26%*
Hmean     tput-30 150349470.98 (   0.00%) 156507070.73 *   4.10%*
Hmean     tput-48 237195937.69 (   0.00%) 242353597.17 *   2.17%*
Hmean     tput-79 360252509.37 (   0.00%) 362635169.23 *   0.66%*
Hmean     tput-96 394571737.90 (   0.00%) 400952978.48 *   1.62%*

2-24 threads (on 1NUMA * 24cores = 24cores)
                 lkp-pbzip2               lkp-pbzip2
                 w/o patch                w/ patch
Hmean     tput-2   11071705.49 (   0.00%)  11296869.10 *   2.03%*
Hmean     tput-4   20782165.19 (   0.00%)  21949232.15 *   5.62%*
Hmean     tput-6   30489565.14 (   0.00%)  33023026.96 *   8.31%*
Hmean     tput-8   40376495.80 (   0.00%)  42779286.27 *   5.95%*
Hmean     tput-12  61264033.85 (   0.00%)  62995632.78 *   2.83%*
Hmean     tput-18  86697139.39 (   0.00%)  86461545.74 (  -0.27%)
Hmean     tput-24 104854637.04 (   0.00%) 104522649.46 *  -0.32%*

In the case of 6 threads and 8 threads, we see the greatest performance
improvement.

Similar improvement can be seen on lkp-pixz though the improvement is
smaller:

* lkp-pixz benchmark

2-24 threads lkp-pixz (on 1NUMA * 24cores = 24cores)
                  lkp-pixz               lkp-pixz
                  w/o patch              w/ patch
Hmean     tput-2   6486981.16 (   0.00%)  6561515.98 *   1.15%*
Hmean     tput-4  11645766.38 (   0.00%) 11614628.43 (  -0.27%)
Hmean     tput-6  15429943.96 (   0.00%) 15957350.76 *   3.42%*
Hmean     tput-8  19974087.63 (   0.00%) 20413746.98 *   2.20%*
Hmean     tput-12 28172068.18 (   0.00%) 28751997.06 *   2.06%*
Hmean     tput-18 39413409.54 (   0.00%) 39896830.55 *   1.23%*
Hmean     tput-24 49101815.85 (   0.00%) 49418141.47 *   0.64%*

* SPECrate benchmark

4,8,16 copies mcf_r(on 1NUMA * 32cores = 32cores)
		Base     	 	Base
		Run Time   	 	Rate
		-------  	 	---------
4 Copies	w/o 580 (w/ 570)       	w/o 11.1 (w/ 11.3)
8 Copies	w/o 647 (w/ 605)       	w/o 20.0 (w/ 21.4, +7%)
16 Copies	w/o 844 (w/ 844)       	w/o 30.6 (w/ 30.6)

32 Copies(on 4NUMA * 32 cores = 128cores)
[w/o patch]
                 Base     Base        Base
Benchmarks       Copies  Run Time     Rate
--------------- -------  ---------  ---------
500.perlbench_r      32        584       87.2  *
502.gcc_r            32        503       90.2  *
505.mcf_r            32        745       69.4  *
520.omnetpp_r        32       1031       40.7  *
523.xalancbmk_r      32        597       56.6  *
525.x264_r            1         --            CE
531.deepsjeng_r      32        336      109    *
541.leela_r          32        556       95.4  *
548.exchange2_r      32        513      163    *
557.xz_r             32        530       65.2  *
 Est. SPECrate2017_int_base              80.3

[w/ patch]
                  Base     Base        Base
Benchmarks       Copies  Run Time     Rate
--------------- -------  ---------  ---------
500.perlbench_r      32        580      87.8 (+0.688%)  *
502.gcc_r            32        477      95.1 (+5.432%)  *
505.mcf_r            32        644      80.3 (+13.574%) *
520.omnetpp_r        32        942      44.6 (+9.58%)   *
523.xalancbmk_r      32        560      60.4 (+6.714%%) *
525.x264_r            1         --           CE
531.deepsjeng_r      32        337      109  (+0.000%) *
541.leela_r          32        554      95.6 (+0.210%) *
548.exchange2_r      32        515      163  (+0.000%) *
557.xz_r             32        524      66.0 (+1.227%) *
 Est. SPECrate2017_int_base              83.7 (+4.062%)

On the other hand, it is slightly helpful to CPU-bound tasks like
kernbench:

* 24-96 threads kernbench (on 4NUMA * 24cores = 96cores)
                     kernbench              kernbench
                     w/o cluster            w/ cluster
Min       user-24    12054.67 (   0.00%)    12024.19 (   0.25%)
Min       syst-24     1751.51 (   0.00%)     1731.68 (   1.13%)
Min       elsp-24      600.46 (   0.00%)      598.64 (   0.30%)
Min       user-48    12361.93 (   0.00%)    12315.32 (   0.38%)
Min       syst-48     1917.66 (   0.00%)     1892.73 (   1.30%)
Min       elsp-48      333.96 (   0.00%)      332.57 (   0.42%)
Min       user-96    12922.40 (   0.00%)    12921.17 (   0.01%)
Min       syst-96     2143.94 (   0.00%)     2110.39 (   1.56%)
Min       elsp-96      211.22 (   0.00%)      210.47 (   0.36%)
Amean     user-24    12063.99 (   0.00%)    12030.78 *   0.28%*
Amean     syst-24     1755.20 (   0.00%)     1735.53 *   1.12%*
Amean     elsp-24      601.60 (   0.00%)      600.19 (   0.23%)
Amean     user-48    12362.62 (   0.00%)    12315.56 *   0.38%*
Amean     syst-48     1921.59 (   0.00%)     1894.95 *   1.39%*
Amean     elsp-48      334.10 (   0.00%)      332.82 *   0.38%*
Amean     user-96    12925.27 (   0.00%)    12922.63 (   0.02%)
Amean     syst-96     2146.66 (   0.00%)     2122.20 *   1.14%*
Amean     elsp-96      211.96 (   0.00%)      211.79 (   0.08%)

Note this patch isn't an universal win, it might hurt those workload
which can benefit from packing. Though tasks which want to take
advantages of lower communication latency of one cluster won't
necessarily been packed in one cluster while kernel is not aware of
clusters, they have some chance to been randomly packed. But this
patch will make them spread anyway.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/Kconfig             | 7 +++++++
 include/linux/sched/topology.h | 7 +++++++
 include/linux/topology.h       | 7 +++++++
 kernel/sched/topology.c        | 5 +++++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fdcd54d39c1e..7a3cc2314a03 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -992,6 +992,13 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
+config SCHED_CLUSTER
+	bool "Cluster scheduler support"
+	help
+	  Cluster scheduler support improves the CPU scheduler's decision
+	  making when dealing with machines that have clusters(sharing internal
+	  bus or sharing LLC cache tag). If unsure say N here.
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	help
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..2f9166f6dec8 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -42,6 +42,13 @@ static inline int cpu_smt_flags(void)
 }
 #endif
 
+#ifdef CONFIG_SCHED_CLUSTER
+static inline int cpu_cluster_flags(void)
+{
+	return SD_SHARE_PKG_RESOURCES;
+}
+#endif
+
 #ifdef CONFIG_SCHED_MC
 static inline int cpu_core_flags(void)
 {
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 80d27d717631..0b3704ad13c8 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -212,6 +212,13 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
 
+#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
+static inline const struct cpumask *cpu_cluster_mask(int cpu)
+{
+	return topology_cluster_cpumask(cpu);
+}
+#endif
+
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b77ad49dc14f..546cfb1c728e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1625,6 +1625,11 @@ static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
+
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 #endif
-- 
2.25.1

