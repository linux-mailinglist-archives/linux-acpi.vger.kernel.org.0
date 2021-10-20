Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B24343D5
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 05:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTDZr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 23:25:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:31696 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhJTDZr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Oct 2021 23:25:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="227448140"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="227448140"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 20:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="662078532"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.132])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2021 20:23:27 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI/PRM: Handle memory allocation and memory remap failure
Date:   Wed, 20 Oct 2021 11:23:17 +0800
Message-Id: <1634700197-70709-2-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634700197-70709-1-git-send-email-aubrey.li@intel.com>
References: <1634700197-70709-1-git-send-email-aubrey.li@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Handle memory allocation and memory remap failure in acpi_parse_prmt()
when system runs out of memory to avoid the potential NULL pointer
dereference errors.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 drivers/acpi/prmt.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index aa02221..4d3a219 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -96,7 +96,7 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 	struct acpi_prmt_handler_info *handler_info;
 	struct prm_handler_info *th;
 	struct prm_module_info *tm;
-	u64 mmio_count = 0;
+	u64 *mmio_count;
 	u64 cur_handler = 0;
 	u32 module_info_size = 0;
 	u64 mmio_range_size = 0;
@@ -105,6 +105,8 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 	module_info = (struct acpi_prmt_module_info *) header;
 	module_info_size = struct_size(tm, handlers, module_info->handler_info_count);
 	tm = kmalloc(module_info_size, GFP_KERNEL);
+	if (!tm)
+		goto parse_prmt_out1;
 
 	guid_copy(&tm->guid, (guid_t *) module_info->module_guid);
 	tm->major_rev = module_info->major_rev;
@@ -117,14 +119,24 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		 * Each module is associated with a list of addr
 		 * ranges that it can use during the service
 		 */
-		mmio_count = *(u64 *) memremap(module_info->mmio_list_pointer, 8, MEMREMAP_WB);
-		mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
+		mmio_count = (u64 *) memremap(module_info->mmio_list_pointer, 8, MEMREMAP_WB);
+		if (!mmio_count)
+			goto parse_prmt_out2;
+
+		mmio_range_size = struct_size(tm->mmio_info, addr_ranges, *mmio_count);
 		tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
+		if (!tm->mmio_info)
+			goto parse_prmt_out3;
+
 		temp_mmio = memremap(module_info->mmio_list_pointer, mmio_range_size, MEMREMAP_WB);
+		if (!temp_mmio)
+			goto parse_prmt_out4;
 		memmove(tm->mmio_info, temp_mmio, mmio_range_size);
 	} else {
-		mmio_range_size = struct_size(tm->mmio_info, addr_ranges, mmio_count);
-		tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
+		tm->mmio_info = kmalloc(sizeof(*tm->mmio_info), GFP_KERNEL);
+		if (!tm->mmio_info)
+			goto parse_prmt_out2;
+
 		tm->mmio_info->mmio_count = 0;
 	}
 
@@ -142,6 +154,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
+
+parse_prmt_out4:
+	kfree(tm->mmio_info);
+parse_prmt_out3:
+	memunmap(mmio_count);
+parse_prmt_out2:
+	kfree(tm);
+parse_prmt_out1:
+	return -ENOMEM;
 }
 
 #define GET_MODULE	0
-- 
2.7.4

