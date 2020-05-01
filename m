Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73A71C1090
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgEAJ7D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 05:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgEAJ7D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 05:59:03 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47722184D;
        Fri,  1 May 2020 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588327142;
        bh=S5ZDpsLyWfU1rfV4y4NUHWurv9nZWihyTCZvqMc9DQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhW+0ZLDcOsNllJkazCkwC95mG97vEEaoIPqESx4Y/nE4MsVqM3zP3zv15bYonqhb
         Fu/AHXMeGZkOGxU+fQhCSA19SAGN4DEnot7TJQFS69Z7yzYuR18VcJg0eaOtP5X7Ke
         ncF25Mx1Qh/uHJRKPXqZypW+1Q6pihB6bVN8BUpg=
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
Subject: [PATCH RFC 2/2] ACPI/IORT: work around num_ids ambiguity
Date:   Fri,  1 May 2020 11:58:43 +0200
Message-Id: <20200501095843.25401-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501095843.25401-1-ardb@kernel.org>
References: <20200501095843.25401-1-ardb@kernel.org>
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/arm64/iort.c | 23 +++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 98be18266a73..d826dd9dc4c5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -316,10 +316,19 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 	}
 
 	if (rid_in < map->input_base ||
-	    (rid_in >= map->input_base + map->id_count))
+	    (rid_in > map->input_base + map->id_count))
 		return -ENXIO;
 
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
 
@@ -404,7 +413,8 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 	/* Parse the ID mapping tree to find specified node type */
 	while (node) {
 		struct acpi_iort_id_mapping *map;
-		int i, index;
+		int i, index, rc = 0;
+		u32 out_ref = 0, map_id = id;
 
 		if (IORT_TYPE_MASK(node->type) & type_mask) {
 			if (id_out)
@@ -438,15 +448,18 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 			if (i == index)
 				continue;
 
-			if (!iort_id_map(map, node->type, id, &id))
+			rc = iort_id_map(map, node->type, map_id, &id);
+			if (!rc)
 				break;
+			if (rc == -EAGAIN)
+				out_ref = map->output_reference;
 		}
 
-		if (i == node->mapping_count)
+		if (i == node->mapping_count && rc != -EAGAIN)
 			goto fail_map;
 
 		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
-				    map->output_reference);
+				    rc ? out_ref : map->output_reference);
 	}
 
 fail_map:
-- 
2.17.1

