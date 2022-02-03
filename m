Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6ED4A8C75
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Feb 2022 20:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiBCTbd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Feb 2022 14:31:33 -0500
Received: from foss.arm.com ([217.140.110.172]:39608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240903AbiBCTbb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Feb 2022 14:31:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FF18147A;
        Thu,  3 Feb 2022 11:31:31 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 750943F774;
        Thu,  3 Feb 2022 11:31:30 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH v2] ACPI/IORT: Check node revision for PMCG resources
Date:   Thu,  3 Feb 2022 19:31:24 +0000
Message-Id: <75628ae41c257fb73588f7bf1c4459160e04be2b.1643916258.git.robin.murphy@arm.com>
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

v2: Simpler workaround, since I realised platform_get_resource()
    should happily just skip over a zero-initialised hole in the
    resource array.

 drivers/acpi/arm64/iort.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 175397913be1..7092b94b2aae 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1371,9 +1371,17 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 	res[0].start = pmcg->page0_base_address;
 	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
 	res[0].flags = IORESOURCE_MEM;
-	res[1].start = pmcg->page1_base_address;
-	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
-	res[1].flags = IORESOURCE_MEM;
+	/*
+	 * The initial version in DEN0049C lacked a way to describe register
+	 * page 1, which makes it broken for most PMCG implementations; in
+	 * that case, just let the driver fail gracefully if it expects to
+	 * find a second memory resource.
+	 */
+	if (node->revision > 0) {
+		res[1].start = pmcg->page1_base_address;
+		res[1].end = pmcg->page1_base_address + SZ_4K - 1;
+		res[1].flags = IORESOURCE_MEM;
+	}
 
 	if (pmcg->overflow_gsiv)
 		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
-- 
2.28.0.dirty

