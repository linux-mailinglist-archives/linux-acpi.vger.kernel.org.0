Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C96DB142
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjDGRMX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDGRMW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532569ED1;
        Fri,  7 Apr 2023 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887541; x=1712423541;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B9VBVgS4nybtHfZE9p+drAXT3PxU7FrJ0X5i9nulIVQ=;
  b=ZY3+yEjDX1xRbEVdEdco/6BvFMKbljjmx1zj6YYFeDI3lwmmgIcuFnEw
   di7eSkmXiP8bLQBjFvqXG/dCWR6SnH71AmAM5bHa4X9lHFdfdc2sYxHrT
   usFlzX/mtgpHjdzkvm4oy1VAz8yOyZrt6rD0U7AJ1kPvfAdCLvjpj6rpU
   WaJNHYsZ7K/r4mSmeGWKWpEZG2gfU12m5O83vhmmlwOICOgS03hdhfSAc
   VPLpqHh+4VqIDwC5oFbPmZ7Q9BFKt/UiChtrd5gkeA1M9Ukq7l5PBKrru
   tcZnWXo1c3bSbDUaUR0lL/WbQ3x2n1V5P7m4FM0jxzXJjmigB6hkbSktm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="323402135"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="323402135"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="717902655"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="717902655"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:20 -0700
Subject: [PATCH 3 04/23] cxl: Add common helpers for cdat parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:19 -0700
Message-ID: <168088753960.1441063.5248646258780465828.stgit@djiang5-mobl3>
In-Reply-To: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
References: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add helper functions to parse the CDAT table and provide a callback to
parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
parsing. The code is patterned after the ACPI table parsing helpers.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Use local headers to handle LE instead of ACPI header
- Reduce complexity of parser function. (Jonathan)
- Directly access header type. (Jonathan)
- Simplify header ptr math. (Jonathan)
- Move parsed counter to the correct location. (Jonathan)
- Add LE to host conversion for entry length
---
 drivers/cxl/core/Makefile |    1 
 drivers/cxl/core/cdat.c   |  100 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h      |   29 +++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/cxl/core/cdat.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ca4ae31d8f57..867a8014b462 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -12,5 +12,6 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
new file mode 100644
index 000000000000..210f4499bddb
--- /dev/null
+++ b/drivers/cxl/core/cdat.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+#include "cxlpci.h"
+#include "cxl.h"
+
+static bool has_handler(struct cdat_subtable_proc *proc)
+{
+	return proc->handler;
+}
+
+static int call_handler(struct cdat_subtable_proc *proc,
+			struct cdat_subtable_entry *ent)
+{
+	if (has_handler(proc))
+		return proc->handler(ent->hdr, proc->arg);
+	return -EINVAL;
+}
+
+static bool cdat_is_subtable_match(struct cdat_subtable_entry *ent)
+{
+	return ent->hdr->type == ent->type;
+}
+
+static int cdat_table_parse_entries(enum cdat_type type,
+				    struct cdat_header *table_header,
+				    struct cdat_subtable_proc *proc)
+{
+	unsigned long table_end, entry_len;
+	struct cdat_subtable_entry entry;
+	int count = 0;
+	int rc;
+
+	if (!has_handler(proc))
+		return -EINVAL;
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	if (type >= CDAT_TYPE_RESERVED)
+		return -EINVAL;
+
+	entry.type = type;
+	entry.hdr = (struct cdat_entry_header *)(table_header + 1);
+
+	while ((unsigned long)entry.hdr < table_end) {
+		entry_len = le16_to_cpu(entry.hdr->length);
+
+		if ((unsigned long)entry.hdr + entry_len > table_end)
+			return -EINVAL;
+
+		if (entry_len == 0)
+			return -EINVAL;
+
+		if (cdat_is_subtable_match(&entry)) {
+			rc = call_handler(proc, &entry);
+			if (rc)
+				return rc;
+			count++;
+		}
+
+		entry.hdr = (struct cdat_entry_header *)((unsigned long)entry.hdr + entry_len);
+	}
+
+	return count;
+}
+
+int cdat_table_parse_dsmas(struct cdat_header *table,
+			   cdat_tbl_entry_handler handler, void *arg)
+{
+	struct cdat_subtable_proc proc = {
+		.handler	= handler,
+		.arg		= arg,
+	};
+
+	return cdat_table_parse_entries(CDAT_TYPE_DSMAS, table, &proc);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dsmas, CXL);
+
+int cdat_table_parse_dslbis(struct cdat_header *table,
+			    cdat_tbl_entry_handler handler, void *arg)
+{
+	struct cdat_subtable_proc proc = {
+		.handler	= handler,
+		.arg		= arg,
+	};
+
+	return cdat_table_parse_entries(CDAT_TYPE_DSLBIS, table, &proc);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dslbis, CXL);
+
+int cdat_table_parse_sslbis(struct cdat_header *table,
+			    cdat_tbl_entry_handler handler, void *arg)
+{
+	struct cdat_subtable_proc proc = {
+		.handler	= handler,
+		.arg		= arg,
+	};
+
+	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0465ef963cd6..45e2f2bf5ef8 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -76,12 +76,34 @@ struct cdat_header {
 	__le32 sequence;
 } __packed;
 
+enum cdat_type {
+	CDAT_TYPE_DSMAS = 0,
+	CDAT_TYPE_DSLBIS,
+	CDAT_TYPE_DSMSCIS,
+	CDAT_TYPE_DSIS,
+	CDAT_TYPE_DSEMTS,
+	CDAT_TYPE_SSLBIS,
+	CDAT_TYPE_RESERVED
+};
+
 struct cdat_entry_header {
 	u8 type;
 	u8 reserved;
 	__le16 length;
 } __packed;
 
+typedef int (*cdat_tbl_entry_handler)(struct cdat_entry_header *header, void *arg);
+
+struct cdat_subtable_proc {
+	cdat_tbl_entry_handler handler;
+	void *arg;
+};
+
+struct cdat_subtable_entry {
+	struct cdat_entry_header *hdr;
+	enum cdat_type type;
+};
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
@@ -90,4 +112,11 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+
+#define cdat_table_parse(x) \
+int cdat_table_parse_##x(struct cdat_header *table, \
+			 cdat_tbl_entry_handler handler, void *arg)
+cdat_table_parse(dsmas);
+cdat_table_parse(dslbis);
+cdat_table_parse(sslbis);
 #endif /* __CXL_PCI_H__ */


