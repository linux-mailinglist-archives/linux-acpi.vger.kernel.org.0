Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9841C1A5D
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgEAQKa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 12:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAQKa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 12:10:30 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C53824957;
        Fri,  1 May 2020 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588349430;
        bh=0Sszvt5a994Rw/6MNs8ExhBptMa9b9Vl/iIWVwl6VKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wh/shXif544RAUtlzDXCytz/e/F8IhDcdAfIS5WdH0tw9GCAUofaRGNxW81x9MQeU
         ducpt0+h9bxXLMh4VHAb6X70tt+JuTq7a+E4iSwTqahUN6PMoHW5WPmMH9YQNIhnCg
         keuOsc84GbwRbLUebJnTs97hsov8uqyHXiB67JpM=
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
Subject: [PATCH v2 2/2] ACPI/IORT: work around num_ids ambiguity
Date:   Fri,  1 May 2020 18:10:14 +0200
Message-Id: <20200501161014.5935-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501161014.5935-1-ardb@kernel.org>
References: <20200501161014.5935-1-ardb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ID mapping table structure of the IORT table describes the size of
a range using a num_ids field carrying the number of IDs in the region
minus one. This has been misinterpreted in the past in the parsing code,
and firmware is known to have shipped where this results in an ambiguity,
where regions that should be adjacent have an overlap of one value.

So let's work around this by detecting this case specifically: when
resolving an ID translation, allow one that matches right at the end of
a multi-ID region to be superseded by a subsequent one.

To prevent potential regressions on broken firmware that happened to
work before, only take the subsequent match into account if it occurs
at the start of a mapping region.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/arm64/iort.c | 40 +++++++++++++++++---
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 98be18266a73..9f139a94a1d3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -300,7 +300,7 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 }
 
 static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
-		       u32 *rid_out)
+		       u32 *rid_out, bool check_overlap)
 {
 	/* Single mapping does not care for input id */
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
@@ -316,10 +316,34 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 	}
 
 	if (rid_in < map->input_base ||
-	    (rid_in >= map->input_base + map->id_count))
+	    (rid_in > map->input_base + map->id_count))
 		return -ENXIO;
 
+	if (check_overlap) {
+		/*
+		 * We already found a mapping for this input ID at the end of
+		 * another region. If it coincides with the start of this
+		 * region, we assume the prior match was due to the off-by-1
+		 * issue mentioned below, and allow it to be superseded.
+		 * Otherwise, things are *really* broken, and we just disregard
+		 * duplicate matches entirely to retain compatibility.
+		 */
+		pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x\n",
+		       map, rid_in);
+		if (rid_in != map->input_base)
+			return -ENXIO;
+	}
+
 	*rid_out = map->output_base + (rid_in - map->input_base);
+
+	/*
+	 * Due to confusion regarding the meaning of the id_count field (which
+	 * carries the number of IDs *minus 1*), we may have to disregard this
+	 * match if it is at the end of the range, and overlaps with the start
+	 * of another one.
+	 */
+	if (map->id_count > 0 && rid_in == map->input_base + map->id_count)
+		return -EAGAIN;
 	return 0;
 }
 
@@ -404,7 +428,8 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 	/* Parse the ID mapping tree to find specified node type */
 	while (node) {
 		struct acpi_iort_id_mapping *map;
-		int i, index;
+		int i, index, rc = 0;
+		u32 out_ref = 0, map_id = id;
 
 		if (IORT_TYPE_MASK(node->type) & type_mask) {
 			if (id_out)
@@ -438,15 +463,18 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 			if (i == index)
 				continue;
 
-			if (!iort_id_map(map, node->type, id, &id))
+			rc = iort_id_map(map, node->type, map_id, &id, out_ref);
+			if (!rc)
 				break;
+			if (rc == -EAGAIN)
+				out_ref = map->output_reference;
 		}
 
-		if (i == node->mapping_count)
+		if (i == node->mapping_count && !out_ref)
 			goto fail_map;
 
 		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
-				    map->output_reference);
+				    rc ? out_ref : map->output_reference);
 	}
 
 fail_map:
-- 
2.17.1

