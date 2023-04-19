Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CB6E8286
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjDSUVl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjDSUVk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:21:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F255BAE;
        Wed, 19 Apr 2023 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935698; x=1713471698;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXgUu3UHA2wefjbi2ckrWfhBIMaIk4ZsYAJgh+lfk7c=;
  b=Z5ERRkPE5T9VTgE51V/S16sz3nk99IWIHwJbaNK8C6bfNwx9Nz+L1CFY
   tv6NP1M8XCy+M3KdxaSN1daISC1XJA8JopytGe1mZE71kjhkoc2Tj5Aqn
   muCub8ekswm/1VjODEr4alfiCZrXJcRiE3BHUkJrQ918VQzbs68AlFOB6
   LlXyF+F7YKA8rwMvJrtLIi7NhFdkuCVH6XUkUhEwPNU/T0trim0URE+SZ
   3GKI9SHGd+yqESrEcHEbbgcl7Z6PG38El4b9ti/ohNjoDh5gASCatjSOu
   GWn+eSlwUvh0Scgf7A0QTpQ+7he7cDFAOY+xCktUDetBCRijMiF47Q20d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431831631"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="431831631"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="722081830"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="722081830"
Received: from jdgarvey-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:37 -0700
Subject: [PATCH v4 06/23] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:21:37 -0700
Message-ID: <168193569717.1178687.294428469465996536.stgit@djiang5-mobl3>
In-Reply-To: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 3022bdd52439..ab584b83010d 100644
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


