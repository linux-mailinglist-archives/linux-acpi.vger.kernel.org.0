Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A66CB0DD
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC0Vo4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjC0Vom (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:44:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193E1FF2;
        Mon, 27 Mar 2023 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953481; x=1711489481;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ujdW4aVFzAQRcZBKJuVkW18/txhJnPiHwlRF2FWgRq4=;
  b=D+ELJchGXt9UgTxRsWu7sBaSAIJzIbS3wyk59Qlqt0SWmazNVdGnRJ6Y
   BVJC6k0Pm8K25Vd9+xQFQjmjLZ3G3riYEY1TRJJUdE7F+Bpo9QE1SHMXX
   gNjRfLtVtDHDEER8mYVZtfYlXnhBx40bB1+9/1lKNxCaJWjQEtVwCcspf
   RuHHzU62/D6rw3G7mFZXcNWpikKgBY2qRLtdPZD6/G9hcAV5MKQEqWNTK
   D/F908H/GHKh9HJB4hFAzp4u+zl8uYyXYcDDK+cJA+wNVIEoOJdgEzJLu
   nswvNY12KCzNJ8yIgP5UE0orQoNuCTkvjv3rUfqgZUXMSSoeZZVnG4fUA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320798971"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320798971"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="857803739"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="857803739"
Received: from spal2-desk3.gar.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:40 -0700
Subject: [PATCH v2 06/21] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:44:39 -0700
Message-ID: <167995347963.2857312.11781710463537827645.stgit@djiang5-mobl3>
In-Reply-To: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
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

Provide a callback to parse the Device Scoped Latency and Bandwidth
Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
contains the bandwidth and latency information that's tied to a DSMAS
handle. The driver will retrieve the read and write latency and
bandwidth associated with the DSMAS which is tied to a DPA range.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Add size check to DSLIBIS table. (Lukas)
- Remove unnecessary entry type check. (Jonathan)
- Move data_type check to after match. (Jonathan)
- Skip unknown data type. (Jonathan)
- Add overflow check for unit multiply. (Jonathan)
- Use dev_warn() when entries parsing fail. (Jonathan)
---
 drivers/cxl/core/cdat.c |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h    |   34 +++++++++++++++++++++++++++++++++-
 drivers/cxl/port.c      |    9 ++++++++-
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index d068609fb6f9..0e88973e9f38 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+#include <linux/overflow.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
@@ -124,3 +125,43 @@ int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
+
+int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
+{
+	struct cdat_dslbis *dslbis = (struct cdat_dslbis *)header;
+	struct list_head *dsmas_list = (struct list_head *)arg;
+	struct dsmas_entry *dent;
+
+	if (dslbis->hdr.length != sizeof(*dslbis)) {
+		pr_warn("Malformed DSLBIS table length: (%lu:%u)\n",
+			(unsigned long)sizeof(*dslbis), dslbis->hdr.length);
+		return -EINVAL;
+	}
+
+	/* Unrecognized data type, we can skip */
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
+			pr_warn("DSLBIS value overflowed!\n");
+
+		dent->qos[dslbis->data_type] = val;
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 9a2468a93d83..1429de49e0c4 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -104,10 +104,21 @@ struct cdat_subtable_entry {
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
+	u64 qos[HMAT_SLLBIS_DATA_TYPE_MAX];
 };
 
 /* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
@@ -120,6 +131,23 @@ struct cdat_dsmas {
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
+/* Flags for subtable above */
+
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
index c8136797d528..6f2b327f7128 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -152,8 +152,15 @@ static int cxl_port_probe(struct device *dev)
 			rc = cdat_table_parse_dsmas(port->cdat.table,
 						    cxl_dsmas_parse_entry,
 						    (void *)&dsmas_list);
-			if (rc < 0)
+			if (rc > 0) {
+				rc = cdat_table_parse_dslbis(port->cdat.table,
+							     cxl_dslbis_parse_entry,
+							     (void *)&dsmas_list);
+				if (rc <= 0)
+					dev_warn(dev, "Failed to parse DSLBIS: %d\n", rc);
+			} else {
 				dev_warn(dev, "Failed to parse DSMAS: %d\n", rc);
+			}
 
 			dsmas_list_destroy(&dsmas_list);
 		}


