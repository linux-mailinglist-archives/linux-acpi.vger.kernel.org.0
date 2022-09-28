Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEEA5EE589
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Sep 2022 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiI1TYZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Sep 2022 15:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiI1TX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Sep 2022 15:23:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2164C10B229
        for <linux-acpi@vger.kernel.org>; Wed, 28 Sep 2022 12:22:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A495B139F;
        Wed, 28 Sep 2022 12:21:37 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF5663F792;
        Wed, 28 Sep 2022 12:21:29 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com, nicolinc@nvidia.com
Subject: [PATCH] ACPI/IORT: Update SMMUv3 DeviceID support
Date:   Wed, 28 Sep 2022 20:21:26 +0100
Message-Id: <4b3e2ead4f392d1a47a7528da119d57918e5d806.1664392886.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

IORT E.e now allows SMMUv3 nodes to describe the DeviceID for MSIs
independently of wired GSIVs, where the previous oddly-restrictive
definition meant that an SMMU without PRI support had to provide a
DeviceID even if it didn't support MSIs either. Support this, with
the usual temporary flag definition while the real one is making
its way through ACPICA.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/iort.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ca2aed86b540..51bc3c1d8d42 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -402,6 +402,10 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	return NULL;
 }
 
+#ifndef ACPI_IORT_SMMU_V3_DEVICEID_VALID
+#define ACPI_IORT_SMMU_V3_DEVICEID_VALID (1 << 4)
+#endif
+
 static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
@@ -418,12 +422,16 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 
 		smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 		/*
-		 * ID mapping index is only ignored if all interrupts are
-		 * GSIV based
+		 * Until IORT E.e (node rev. 5), the ID mapping index was
+		 * defined to be valid unless all interrupts are GSIV-based.
 		 */
-		if (smmu->event_gsiv && smmu->pri_gsiv && smmu->gerr_gsiv
-		    && smmu->sync_gsiv)
+		if (node->revision < 5) {
+			if (smmu->event_gsiv && smmu->pri_gsiv &&
+			    smmu->gerr_gsiv && smmu->sync_gsiv)
+				return -EINVAL;
+		} else if (!(smmu->flags & ACPI_IORT_SMMU_V3_DEVICEID_VALID)) {
 			return -EINVAL;
+		}
 
 		if (smmu->id_mapping_index >= node->mapping_count) {
 			pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
-- 
2.36.1.dirty

