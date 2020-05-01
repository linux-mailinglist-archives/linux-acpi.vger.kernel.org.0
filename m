Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C61C1A5C
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgEAQK2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 12:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAQK2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 12:10:28 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958DD24956;
        Fri,  1 May 2020 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588349427;
        bh=yqjxjNbvDvgpGXMyUQLw+kBshy3NV1WeyfDFrv6omJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4G3H5kE3wbd7qeK9qeWE4ExCS/FA0+Oih5v8KD+XXbnujGMyca+tDEv5zDanbUOI
         ENBgmXzLDHOeoQsXuFSnMoJlbgBmjtVdlxdvmVoneg4lLSz6sGCZInryzzPECBk+I1
         EKhRonUKzOKt2jh9/WPj65yjwx+rea7awSxkiPdQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 1/2] Revert "ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()"
Date:   Fri,  1 May 2020 18:10:13 +0200
Message-Id: <20200501161014.5935-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501161014.5935-1-ardb@kernel.org>
References: <20200501161014.5935-1-ardb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 3c23b83a88d00383e1d498cfa515249aa2fe0238.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/arm64/iort.c | 57 +-------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7d04424189df..98be18266a73 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -299,59 +299,6 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 	return status;
 }
 
-struct iort_workaround_oem_info {
-	char oem_id[ACPI_OEM_ID_SIZE + 1];
-	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
-	u32 oem_revision;
-};
-
-static bool apply_id_count_workaround;
-
-static struct iort_workaround_oem_info wa_info[] __initdata = {
-	{
-		.oem_id		= "HISI  ",
-		.oem_table_id	= "HIP07   ",
-		.oem_revision	= 0,
-	}, {
-		.oem_id		= "HISI  ",
-		.oem_table_id	= "HIP08   ",
-		.oem_revision	= 0,
-	}
-};
-
-static void __init
-iort_check_id_count_workaround(struct acpi_table_header *tbl)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
-		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
-		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
-		    wa_info[i].oem_revision == tbl->oem_revision) {
-			apply_id_count_workaround = true;
-			pr_warn(FW_BUG "ID count for ID mapping entry is wrong, applying workaround\n");
-			break;
-		}
-	}
-}
-
-static inline u32 iort_get_map_max(struct acpi_iort_id_mapping *map)
-{
-	u32 map_max = map->input_base + map->id_count;
-
-	/*
-	 * The IORT specification revision D (Section 3, table 4, page 9) says
-	 * Number of IDs = The number of IDs in the range minus one, but the
-	 * IORT code ignored the "minus one", and some firmware did that too,
-	 * so apply a workaround here to keep compatible with both the spec
-	 * compliant and non-spec compliant firmwares.
-	 */
-	if (apply_id_count_workaround)
-		map_max--;
-
-	return map_max;
-}
-
 static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		       u32 *rid_out)
 {
@@ -368,7 +315,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		return -ENXIO;
 	}
 
-	if (rid_in < map->input_base || rid_in > iort_get_map_max(map))
+	if (rid_in < map->input_base ||
+	    (rid_in >= map->input_base + map->id_count))
 		return -ENXIO;
 
 	*rid_out = map->output_base + (rid_in - map->input_base);
@@ -1703,6 +1651,5 @@ void __init acpi_iort_init(void)
 		return;
 	}
 
-	iort_check_id_count_workaround(iort_table);
 	iort_init_platform_devices();
 }
-- 
2.17.1

