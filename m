Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADC798C33
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Sep 2023 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjIHSFU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Sep 2023 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjIHSFT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2023 14:05:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF62213A;
        Fri,  8 Sep 2023 11:04:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B1BC4339A;
        Fri,  8 Sep 2023 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196224;
        bh=sFVKC6ZtU01nH+4NDc99qk06dtDHrlavBl1Ztc+0BzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVBxIZfRb1OFBHx0arlg4pOlMvqvGe5D/+MuZsiHO7QJFL0UsADzc/7CK3V8sQ95z
         RCjS5Iq2uZqoKyto5cHbCd44VAfkFUDIsSabWbpnxiYFSHhXwYsK1TGFqFkGu45rO9
         gVQX3+SZZXhYGOcA9n0SSGjYtmjWpSRVIvqzv82fMzrSHQLmNMgZgoqd/07gm0Ig9w
         WgMOLZpoBtf1nWWtKqdW0C89EpDKQKQ4tVm44UpnD4ecEs4j4p9sbHUJGjGeqSwoKt
         czPmfPtcL7RSDsS6XFYrfajbOUVfwjADmpK8UkRp6gYN6IMU40o4M3xrnZfJeNmVCI
         FCcZAZL3tkmtw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        corbet@lwn.net, lpieralisi@kernel.org, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, maz@kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, anshuman.khandual@arm.com,
        james.morse@arm.com, sebastian.reichel@collabora.com,
        zhengyan@asrmicro.com, shahuang@redhat.com, arnd@arndb.de,
        linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 6/8] perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09
Date:   Fri,  8 Sep 2023 14:03:17 -0400
Message-Id: <20230908180320.3458596-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180320.3458596-1-sashal@kernel.org>
References: <20230908180320.3458596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit 0242737dc4eb9f6e9a5ea594b3f93efa0b12f28d ]

Some HiSilicon SMMU PMCG suffers the erratum 162001900 that the PMU
disable control sometimes fail to disable the counters. This will lead
to error or inaccurate data since before we enable the counters the
counter's still counting for the event used in last perf session.

This patch tries to fix this by hardening the global disable process.
Before disable the PMU, writing an invalid event type (0xffff) to
focibly stop the counters. Correspondingly restore each events on
pmu::pmu_enable().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Link: https://lore.kernel.org/r/20230814124012.58013-1-yangyicong@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/acpi/arm64/iort.c              |  5 ++-
 drivers/perf/arm_smmuv3_pmu.c          | 46 +++++++++++++++++++++++++-
 include/linux/acpi_iort.h              |  1 +
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 4f3206495217c..10a26d44ef4a9 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -149,6 +149,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | Hip08 SMMU PMCG | #162001900      | N/A                         |
+|                | Hip09 SMMU PMCG |                 |                             |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 50ed949dc1449..554943be26984 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1474,7 +1474,10 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 static struct acpi_platform_list pmcg_plat_info[] __initdata = {
 	/* HiSilicon Hip08 Platform */
 	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
-	 "Erratum #162001800", IORT_SMMU_V3_PMCG_HISI_HIP08},
+	 "Erratum #162001800, Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP08},
+	/* HiSilicon Hip09 Platform */
+	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
+	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
 	{ }
 };
 
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index f5a33dbe7acb9..6ebe72b862661 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -95,6 +95,7 @@
 #define SMMU_PMCG_PA_SHIFT              12
 
 #define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+#define SMMU_PMCG_HARDEN_DISABLE        BIT(1)
 
 static int cpuhp_state_num;
 
@@ -138,6 +139,20 @@ static inline void smmu_pmu_enable(struct pmu *pmu)
 	writel(SMMU_PMCG_CR_ENABLE, smmu_pmu->reg_base + SMMU_PMCG_CR);
 }
 
+static int smmu_pmu_apply_event_filter(struct smmu_pmu *smmu_pmu,
+				       struct perf_event *event, int idx);
+
+static inline void smmu_pmu_enable_quirk_hip08_09(struct pmu *pmu)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
+	unsigned int idx;
+
+	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
+		smmu_pmu_apply_event_filter(smmu_pmu, smmu_pmu->events[idx], idx);
+
+	smmu_pmu_enable(pmu);
+}
+
 static inline void smmu_pmu_disable(struct pmu *pmu)
 {
 	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
@@ -146,6 +161,22 @@ static inline void smmu_pmu_disable(struct pmu *pmu)
 	writel(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CTRL);
 }
 
+static inline void smmu_pmu_disable_quirk_hip08_09(struct pmu *pmu)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
+	unsigned int idx;
+
+	/*
+	 * The global disable of PMU sometimes fail to stop the counting.
+	 * Harden this by writing an invalid event type to each used counter
+	 * to forcibly stop counting.
+	 */
+	for_each_set_bit(idx, smmu_pmu->used_counters, smmu_pmu->num_counters)
+		writel(0xffff, smmu_pmu->reg_base + SMMU_PMCG_EVTYPER(idx));
+
+	smmu_pmu_disable(pmu);
+}
+
 static inline void smmu_pmu_counter_set_value(struct smmu_pmu *smmu_pmu,
 					      u32 idx, u64 value)
 {
@@ -719,7 +750,10 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 	switch (model) {
 	case IORT_SMMU_V3_PMCG_HISI_HIP08:
 		/* HiSilicon Erratum 162001800 */
-		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
+		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY | SMMU_PMCG_HARDEN_DISABLE;
+		break;
+	case IORT_SMMU_V3_PMCG_HISI_HIP09:
+		smmu_pmu->options |= SMMU_PMCG_HARDEN_DISABLE;
 		break;
 	}
 
@@ -806,6 +840,16 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	smmu_pmu_get_acpi_options(smmu_pmu);
 
+	/*
+	 * For platforms suffer this quirk, the PMU disable sometimes fails to
+	 * stop the counters. This will leads to inaccurate or error counting.
+	 * Forcibly disable the counters with these quirk handler.
+	 */
+	if (smmu_pmu->options & SMMU_PMCG_HARDEN_DISABLE) {
+		smmu_pmu->pmu.pmu_enable = smmu_pmu_enable_quirk_hip08_09;
+		smmu_pmu->pmu.pmu_disable = smmu_pmu_disable_quirk_hip08_09;
+	}
+
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
 	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq,
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1a12baa58e409..136dba94c646f 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -21,6 +21,7 @@
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
 #define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP09     0x00000002 /* HiSilicon HIP09 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
-- 
2.40.1

