Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA016DB144
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjDGRMa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjDGRM3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5F9ED1;
        Fri,  7 Apr 2023 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887548; x=1712423548;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8rvJ7QszvsHUKLtT53f6fv6GKMN8X/kehNdsili22E=;
  b=hMmBvo+dxlsmuYKzj4ifGXZXN99z9t+bH3CNFfqyqAKSkj8EcT940YCp
   iLwlcEGqZw/4bVoW7v25IueNplhpNA+YdpRW6lzuENvR1CE1IgCjpT/Qc
   Cc1qmEPBLmX28vuKLog1QHXfpRqjOdo3eDfWmopl3+vxVWvXhw4VvtF1Z
   xDKsLU3nbTvvqxMaQ11jSi/kGuUypg83dgdYMJ+4tX+FD5WZFUhHzYbpt
   flh73IQ4UrHQImlv0cAhFJ6u5p+h7XB4FdW7FSVewT9tcQFbsDo6YPqTK
   d8nCWH44wpCQ4SbmtaELy1Hlq7HB51WJBcY0n9YohFcS0qrlkjAfHEYdS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="331684728"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="331684728"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681086965"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681086965"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:26 -0700
Subject: [PATCH 3 05/23] cxl: Add callback to parse the DSMAS subtables from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:25 -0700
Message-ID: <168088754594.1441063.15913679905112812064.stgit@djiang5-mobl3>
In-Reply-To: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
References: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Provide a callback function to the CDAT parser in order to parse the Device
Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
DPA range and its associated attributes in each entry. See the CDAT
specification for details.

Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
Structure (DSMAS)

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Add spec section number. (Alison)
- Remove cast from void *. (Alison)
- Refactor cxl_port_probe() block. (Alison)
- Move CDAT parse to cxl_endpoint_port_probe()

v2:
- Add DSMAS table size check. (Lukas)
- Use local DSMAS header for LE handling.
- Remove dsmas lock. (Jonathan)
- Fix handle size (Jonathan)
- Add LE to host conversion for DSMAS address and length.
- Make dsmas_list local
---
 drivers/cxl/core/cdat.c |   26 ++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    1 +
 drivers/cxl/cxlpci.h    |   18 ++++++++++++++++++
 drivers/cxl/port.c      |   22 ++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 210f4499bddb..6f20af83a3ed 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -98,3 +98,29 @@ int cdat_table_parse_sslbis(struct cdat_header *table,
 	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
 }
 EXPORT_SYMBOL_NS_GPL(cdat_table_parse_sslbis, CXL);
+
+int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
+{
+	struct cdat_dsmas *dsmas = (struct cdat_dsmas *)header;
+	struct list_head *dsmas_list = arg;
+	struct dsmas_entry *dent;
+
+	if (dsmas->hdr.length != sizeof(*dsmas)) {
+		pr_warn("Malformed DSMAS table length: (%lu:%u)\n",
+			 (unsigned long)sizeof(*dsmas), dsmas->hdr.length);
+		return -EINVAL;
+	}
+
+	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
+	if (!dent)
+		return -ENOMEM;
+
+	dent->handle = dsmas->dsmad_handle;
+	dent->dpa_range.start = le64_to_cpu(dsmas->dpa_base_address);
+	dent->dpa_range.end = le64_to_cpu(dsmas->dpa_base_address) +
+			      le64_to_cpu(dsmas->dpa_length) - 1;
+	list_add_tail(&dent->list, dsmas_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cc3309794b45..9d0e22fe72c0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/list.h>
 #include <linux/io.h>
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 45e2f2bf5ef8..9a2468a93d83 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -104,6 +104,22 @@ struct cdat_subtable_entry {
 	enum cdat_type type;
 };
 
+struct dsmas_entry {
+	struct list_head list;
+	struct range dpa_range;
+	u8 handle;
+};
+
+/* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
+struct cdat_dsmas {
+	struct cdat_entry_header hdr;
+	u8 dsmad_handle;
+	u8 flags;
+	__u16 reserved;
+	__le64 dpa_base_address;
+	__le64 dpa_length;
+} __packed;
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
@@ -119,4 +135,6 @@ int cdat_table_parse_##x(struct cdat_header *table, \
 cdat_table_parse(dsmas);
 cdat_table_parse(dslbis);
 cdat_table_parse(sslbis);
+
+int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 60a865680e22..ec9051f1dd0f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -57,6 +57,16 @@ static int discover_region(struct device *dev, void *root)
 	return 0;
 }
 
+static void dsmas_list_destroy(struct list_head *dsmas_list)
+{
+	struct dsmas_entry *dentry, *n;
+
+	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
+		list_del(&dentry->list);
+		kfree(dentry);
+	}
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -125,6 +135,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	device_for_each_child(&port->dev, root, discover_region);
 	put_device(&root->dev);
 
+	if (port->cdat.table) {
+		LIST_HEAD(dsmas_list);
+
+		rc = cdat_table_parse_dsmas(port->cdat.table,
+					    cxl_dsmas_parse_entry,
+					    (void *)&dsmas_list);
+		if (rc < 0)
+			dev_warn(&port->dev, "Failed to parse DSMAS: %d\n", rc);
+
+		dsmas_list_destroy(&dsmas_list);
+	}
+
 	return 0;
 }
 


