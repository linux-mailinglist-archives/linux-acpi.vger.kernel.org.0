Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97C4343D4
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 05:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJTDZr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 23:25:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:31696 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTDZr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Oct 2021 23:25:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="227448137"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="227448137"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 20:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="662078527"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.132])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2021 20:23:25 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v1 1/2] ACPI/PRM: Remove unnecessary blank lines
Date:   Wed, 20 Oct 2021 11:23:16 +0800
Message-Id: <1634700197-70709-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Just remove unnecessary blank lines, no other code changes

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 drivers/acpi/prmt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 89c22bc..aa02221 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -49,7 +49,6 @@ struct prm_context_buffer {
 };
 #pragma pack()
 
-
 static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
@@ -73,7 +72,6 @@ struct prm_module_info {
 	struct prm_handler_info handlers[];
 };
 
-
 static u64 efi_pa_va_lookup(u64 pa)
 {
 	efi_memory_desc_t *md;
@@ -88,7 +86,6 @@ static u64 efi_pa_va_lookup(u64 pa)
 	return 0;
 }
 
-
 #define get_first_handler(a) ((struct acpi_prmt_handler_info *) ((char *) (a) + a->handler_info_offset))
 #define get_next_handler(a) ((struct acpi_prmt_handler_info *) (sizeof(struct acpi_prmt_handler_info) + (char *) a))
 
@@ -171,7 +168,6 @@ static void *find_guid_info(const guid_t *guid, u8 mode)
 	return NULL;
 }
 
-
 static struct prm_module_info *find_prm_module(const guid_t *guid)
 {
 	return (struct prm_module_info *)find_guid_info(guid, GET_MODULE);
-- 
2.7.4

