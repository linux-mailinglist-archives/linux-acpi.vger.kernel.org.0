Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440B76DB145
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDGRMh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjDGRMe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8E0AD32;
        Fri,  7 Apr 2023 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887553; x=1712423553;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dKdXj5i+OJHFV56/MwG69nLfaS3ZF3t5HAH+8I0B8ec=;
  b=E4dzC/3Yv6aWnpg7GdpHOlNjUoKxxqe/mO5y86of8QYA+Q99iO/dwoVJ
   1jrBg1rcoZX/kHdwQfSnpoAjETpSsDTDuhCTesCXBVPDb8GbE4HHRxZlb
   OqzB4Us3XcxJjx0SckY8tIH2ff403FNWDFD08icWiDCgVQLTmMlfSxCN7
   Ysm9gltgSTagi/5PqhK+pteYxgTi1J4Vk6lzSOf50W4lvBMDJff+cDojc
   Kh/TU1rLyGFGcumyEVyyDbgtrCZg3KNVq1Uq6a6DOyqJ5fsNHp/3cNCFR
   xyoHMb2WO8olXN4PiVCjHhHW5B2b1gPbi0hsTlDFkkhVetp/PuxPwIhqj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="331684753"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="331684753"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681086976"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681086976"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:32 -0700
Subject: [PATCH 3 06/23] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:32 -0700
Message-ID: <168088755202.1441063.7051663951287310170.stgit@djiang5-mobl3>
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

Provide a callback to parse the Device Scoped Latency and Bandwidth
Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
contains the bandwidth and latency information that's tied to a DSMAS
handle. The driver will retrieve the read and write latency and
bandwidth associated with the DSMAS which is tied to a DPA range.

Coherent Device Attribute Table 1.03 2.1 Device Scoped Latency and
Bandwidth Information Structure (DSLBIS)

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Added spec section in commit header. (Alison)
- Remove void * recast. (Alison)
- Rework comment. (Alison)
- Move CDAT parse to cxl_endpoint_port_probe()
- Convert to use 'struct node_hmem_attrs'

v2:
- Add size check to DSLIBIS table. (Lukas)
- Remove unnecessary entry type check. (Jonathan)
- Move data_type check to after match. (Jonathan)
- Skip unknown data type. (Jonathan)
- Add overflow check for unit multiply. (Jonathan)
- Use dev_warn() when entries parsing fail. (Jonathan)
---
 drivers/cxl/core/cdat.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h    |   34 +++++++++++++++++++++++-
 drivers/cxl/port.c      |   11 +++++++-
 3 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6f20af83a3ed..e8b9bb99dfdf 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+#include <linux/overflow.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
@@ -124,3 +125,70 @@ int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
+
+static void cxl_hmem_attrs_set(struct node_hmem_attrs *attrs,
+			       int access, unsigned int val)
+{
+	switch (access) {
+	case HMAT_SLLBIS_ACCESS_LATENCY:
+		attrs->read_latency = val;
+		attrs->write_latency = val;
+		break;
+	case HMAT_SLLBIS_READ_LATENCY:
+		attrs->read_latency = val;
+		break;
+	case HMAT_SLLBIS_WRITE_LATENCY:
+		attrs->write_latency = val;
+		break;
+	case HMAT_SLLBIS_ACCESS_BANDWIDTH:
+		attrs->read_bandwidth = val;
+		attrs->write_bandwidth = val;
+		break;
+	case HMAT_SLLBIS_READ_BANDWIDTH:
+		attrs->read_bandwidth = val;
+		break;
+	case HMAT_SLLBIS_WRITE_BANDWIDTH:
+		attrs->write_bandwidth = val;
+		break;
+	}
+}
+
+int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
+{
+	struct cdat_dslbis *dslbis = (struct cdat_dslbis *)header;
+	struct list_head *dsmas_list = arg;
+	struct dsmas_entry *dent;
+
+	if (dslbis->hdr.length != sizeof(*dslbis)) {
+		pr_warn("Malformed DSLBIS table length: (%lu:%u)\n",
+			(unsigned long)sizeof(*dslbis), dslbis->hdr.length);
+		return -EINVAL;
+	}
+
+	/* Skip unrecognized data type */
+	if (dslbis->data_type >= HMAT_SLLBIS_DATA_TYPE_MAX)
+		return 0;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		u64 val;
+		int rc;
+
+		if (dslbis->handle != dent->handle)
+			continue;
+
+		/* Not a memory type, skip */
+		if ((dslbis->flags & DSLBIS_MEM_MASK) != DSLBIS_MEM_MEMORY)
+			return 0;
+
+		rc = check_mul_overflow(le64_to_cpu(dslbis->entry_base_unit),
+					le16_to_cpu(dslbis->entry[0]), &val);
+		if (unlikely(rc))
+			pr_warn("DSLBIS value overflowed.\n");
+
+		cxl_hmem_attrs_set(&dent->hmem_attrs, dslbis->data_type, val);
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 9a2468a93d83..0f36fb23055c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #ifndef __CXL_PCI_H__
 #define __CXL_PCI_H__
+#include <linux/node.h>
 #include <linux/pci.h>
 #include "cxl.h"
 
@@ -104,10 +105,21 @@ struct cdat_subtable_entry {
 	enum cdat_type type;
 };
 
+enum {
+	HMAT_SLLBIS_ACCESS_LATENCY = 0,
+	HMAT_SLLBIS_READ_LATENCY,
+	HMAT_SLLBIS_WRITE_LATENCY,
+	HMAT_SLLBIS_ACCESS_BANDWIDTH,
+	HMAT_SLLBIS_READ_BANDWIDTH,
+	HMAT_SLLBIS_WRITE_BANDWIDTH,
+	HMAT_SLLBIS_DATA_TYPE_MAX
+};
+
 struct dsmas_entry {
 	struct list_head list;
 	struct range dpa_range;
 	u8 handle;
+	struct node_hmem_attrs hmem_attrs;
 };
 
 /* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
@@ -120,6 +132,22 @@ struct cdat_dsmas {
 	__le64 dpa_length;
 } __packed;
 
+/* Sub-table 1: Device Scoped Latency and Bandwidth Information Structure (DSLBIS) */
+struct cdat_dslbis {
+	struct cdat_entry_header hdr;
+	u8 handle;
+	u8 flags;
+	u8 data_type;
+	u8 reserved;
+	__le64 entry_base_unit;
+	__le16 entry[3];
+	__le16 reserved2;
+} __packed;
+
+/* Flags for DSLBIS subtable */
+#define DSLBIS_MEM_MASK		GENMASK(3, 0)
+#define DSLBIS_MEM_MEMORY	0
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
@@ -136,5 +164,9 @@ cdat_table_parse(dsmas);
 cdat_table_parse(dslbis);
 cdat_table_parse(sslbis);
 
-int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
+#define cxl_parse_entry(x) \
+int cxl_##x##_parse_entry(struct cdat_entry_header *header, void *arg)
+
+cxl_parse_entry(dsmas);
+cxl_parse_entry(dslbis);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ec9051f1dd0f..36e32f2e2ca9 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -141,8 +141,17 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		rc = cdat_table_parse_dsmas(port->cdat.table,
 					    cxl_dsmas_parse_entry,
 					    (void *)&dsmas_list);
-		if (rc < 0)
+		if (rc > 0) {
+			rc = cdat_table_parse_dslbis(port->cdat.table,
+						     cxl_dslbis_parse_entry,
+						     (void *)&dsmas_list);
+			if (rc <= 0) {
+				dev_warn(&port->dev,
+					 "Failed to parse DSLBIS: %d\n", rc);
+			}
+		} else {
 			dev_warn(&port->dev, "Failed to parse DSMAS: %d\n", rc);
+		}
 
 		dsmas_list_destroy(&dsmas_list);
 	}


