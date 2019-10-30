Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5677BE9669
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2019 07:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfJ3GeJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Oct 2019 02:34:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:61172 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJ3GeI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Oct 2019 02:34:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="203095707"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 23:34:05 -0700
From:   Tao Xu <tao3.xu@intel.com>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org, keith.busch@intel.com,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tao Xu <tao3.xu@intel.com>, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH] ACPI/HMAT: use %u instead of %d to print u32 variables
Date:   Wed, 30 Oct 2019 14:34:03 +0800
Message-Id: <20191030063403.20128-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use %u instead of %d to print u32 variables to expand the value range,
especially when latency or bandwidth value is bigger than INT_MAX.
Then HMAT latency can support up to 4.29s and bandwidth can support
up to 4PB/s.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

This patch is based on:
EFI Specific Purpose Memory Support,
https://lore.kernel.org/patchwork/cover/1139858/
---
 drivers/acpi/numa/hmat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 1ce366a7bc55..f96e443990c1 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -293,7 +293,7 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 	u8 type, mem_hier;
 
 	if (hmat_loc->header.length < sizeof(*hmat_loc)) {
-		pr_notice("HMAT: Unexpected locality header length: %d\n",
+		pr_notice("HMAT: Unexpected locality header length: %u\n",
 			 hmat_loc->header.length);
 		return -EINVAL;
 	}
@@ -305,12 +305,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 	total_size = sizeof(*hmat_loc) + sizeof(*entries) * ipds * tpds +
 		     sizeof(*inits) * ipds + sizeof(*targs) * tpds;
 	if (hmat_loc->header.length < total_size) {
-		pr_notice("HMAT: Unexpected locality header length:%d, minimum required:%d\n",
+		pr_notice("HMAT: Unexpected locality header length:%u, minimum required:%u\n",
 			 hmat_loc->header.length, total_size);
 		return -EINVAL;
 	}
 
-	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
+	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
 		hmat_loc->flags, hmat_data_type(type), ipds, tpds,
 		hmat_loc->entry_base_unit);
 
@@ -323,7 +323,7 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			value = hmat_normalize(entries[init * tpds + targ],
 					       hmat_loc->entry_base_unit,
 					       type);
-			pr_info("  Initiator-Target[%d-%d]:%d%s\n",
+			pr_info("  Initiator-Target[%u-%u]:%u%s\n",
 				inits[init], targs[targ], value,
 				hmat_data_type_suffix(type));
 
@@ -350,13 +350,13 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 	u32 attrs;
 
 	if (cache->header.length < sizeof(*cache)) {
-		pr_notice("HMAT: Unexpected cache header length: %d\n",
+		pr_notice("HMAT: Unexpected cache header length: %u\n",
 			 cache->header.length);
 		return -EINVAL;
 	}
 
 	attrs = cache->cache_attributes;
-	pr_info("HMAT: Cache: Domain:%d Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
+	pr_info("HMAT: Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
 		cache->memory_PD, cache->cache_size, attrs,
 		cache->number_of_SMBIOShandles);
 
@@ -411,17 +411,17 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 	struct memory_target *target = NULL;
 
 	if (p->header.length != sizeof(*p)) {
-		pr_notice("HMAT: Unexpected address range header length: %d\n",
+		pr_notice("HMAT: Unexpected address range header length: %u\n",
 			 p->header.length);
 		return -EINVAL;
 	}
 
 	if (hmat_revision == 1)
-		pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
+		pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->reserved3, p->reserved4, p->flags, p->processor_PD,
 			p->memory_PD);
 	else
-		pr_info("HMAT: Memory Flags:%04x Processor Domain:%d Memory Domain:%d\n",
+		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->flags, p->processor_PD, p->memory_PD);
 
 	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
-- 
2.20.1

