Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA14A49CA
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 16:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349217AbiAaPDc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 10:03:32 -0500
Received: from foss.arm.com ([217.140.110.172]:58630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244954AbiAaPDc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jan 2022 10:03:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A336ED1;
        Mon, 31 Jan 2022 07:03:31 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83B313F73B;
        Mon, 31 Jan 2022 07:03:30 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] ACPI/IORT: Check node revision for PMCG resources
Date:   Mon, 31 Jan 2022 15:03:24 +0000
Message-Id: <a262d1122f493c83eb48fd643e1c51019ab93c67.1643641404.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The original version of the IORT PMCG definition had an oversight
wherein there was no way to describe the second register page for an
implementation using the recommended RELOC_CTRS feature. Although the
spec was fixed, and the final patches merged to ACPICA and Linux written
against the new version, it seems that some old firmware based on the
original revision has survived and turned up in the wild.

Add a check for the original PMCG definition, and avoid filling in the
second memory resource with nonsense if so. Otherwise it is likely that
something horrible will happen when the PMCG driver attempts to probe.

Reported-by: Michael Petlan <mpetlan@redhat.com>
Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/iort.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3b23fb775ac4..aaa1f0411a5a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1344,16 +1344,17 @@ static int __init arm_smmu_v3_pmcg_count_resources(struct acpi_iort_node *node)
 	pmcg = (struct acpi_iort_pmcg *)node->node_data;
 
 	/*
-	 * There are always 2 memory resources.
-	 * If the overflow_gsiv is present then add that for a total of 3.
+	 * There should normally be 2 memory resources, but apparently the
+	 * oversight from IORT rev. C managed to escape into the wild.
 	 */
-	return pmcg->overflow_gsiv ? 3 : 2;
+	return 1 + (node->revision > 0) + (pmcg->overflow_gsiv != 0);
 }
 
 static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 						   struct acpi_iort_node *node)
 {
 	struct acpi_iort_pmcg *pmcg;
+	int n = 1;
 
 	/* Retrieve PMCG specific data */
 	pmcg = (struct acpi_iort_pmcg *)node->node_data;
@@ -1361,13 +1362,15 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 	res[0].start = pmcg->page0_base_address;
 	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
 	res[0].flags = IORESOURCE_MEM;
-	res[1].start = pmcg->page1_base_address;
-	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
-	res[1].flags = IORESOURCE_MEM;
+	if (node->revision > 0) {
+		res[n].start = pmcg->page1_base_address;
+		res[n].end = pmcg->page1_base_address + SZ_4K - 1;
+		res[n++].flags = IORESOURCE_MEM;
+	}
 
 	if (pmcg->overflow_gsiv)
 		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
-				       ACPI_EDGE_SENSITIVE, &res[2]);
+				       ACPI_EDGE_SENSITIVE, &res[n]);
 }
 
 static struct acpi_platform_list pmcg_plat_info[] __initdata = {
-- 
2.28.0.dirty

