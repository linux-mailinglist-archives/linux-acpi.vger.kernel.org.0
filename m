Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFDC3ABF3F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 01:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhFQXSs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 19:18:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:24399 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232850AbhFQXSr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 19:18:47 -0400
IronPort-SDR: FJZO6hNeeYC8G9+HfxLlgj0wNjAvhK0mEPjhRz4rvi+y0WuprofCl4IBwCLMSM+8aeJdkGQBwp
 qcZo2m6h3zQA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="203441869"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="203441869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:16:39 -0700
IronPort-SDR: U6WPYejwSLFbaQ1vkSm1wGkitLyC/FKTED2fpXALtRuSNsKoG1fLeAyIWSvBNOsV6mJNuU38JL
 0wKNmJTqcKEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="488832479"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2021 16:16:39 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v5 2/2] cxl/acpi: Use the ACPI CFMWS to create static decoder objects
Date:   Thu, 17 Jun 2021 16:12:16 -0700
Message-Id: <d2b73eecfb7ea22e1103f1894b271a89958b4c41.1623968958.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623968958.git.alison.schofield@intel.com>
References: <cover.1623968958.git.alison.schofield@intel.com>
In-Reply-To: <cover.1623968958.git.alison.schofield@intel.com>
References: <cover.1623968958.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
for each memory resource.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 122 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3afdee8f334a..8ae89273f58e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -10,6 +10,126 @@
 
 static struct acpi_table_header *acpi_cedt;
 
+/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
+#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
+#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
+
+static unsigned long cfmws_to_decoder_flags(int restrictions)
+{
+	unsigned long flags = 0;
+
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
+		flags |= CXL_DECODER_F_TYPE2;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
+		flags |= CXL_DECODER_F_TYPE3;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
+		flags |= CXL_DECODER_F_RAM;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
+		flags |= CXL_DECODER_F_PMEM;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
+		flags |= CXL_DECODER_F_LOCK;
+
+	return flags;
+}
+
+static int cxl_acpi_cfmws_verify(struct device *dev,
+				 struct acpi_cedt_cfmws *cfmws)
+{
+	int expected_len;
+
+	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
+		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
+		dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(cfmws->window_size, SZ_256M)) {
+		dev_err(dev, "CFMWS Window Size not 256MB aligned\n");
+		return -EINVAL;
+	}
+
+	expected_len = struct_size((cfmws), interleave_targets,
+				   CFMWS_INTERLEAVE_WAYS(cfmws));
+
+	if (cfmws->header.length < expected_len) {
+		dev_err(dev, "CFMWS length %d less than expected %d\n",
+			cfmws->header.length, expected_len);
+		return -EINVAL;
+	}
+
+	if (cfmws->header.length > expected_len)
+		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
+			cfmws->header.length, expected_len);
+
+	return 0;
+}
+
+static void cxl_add_cfmws_decoders(struct device *dev,
+				   struct cxl_port *root_port)
+{
+	struct acpi_cedt_cfmws *cfmws;
+	struct cxl_decoder *cxld;
+	acpi_size len, cur = 0;
+	void *cedt_subtable;
+	unsigned long flags;
+	int rc;
+
+	len = acpi_cedt->length - sizeof(*acpi_cedt);
+	cedt_subtable = acpi_cedt + 1;
+
+	while (cur < len) {
+		struct acpi_cedt_header *c = cedt_subtable + cur;
+
+		if (c->type != ACPI_CEDT_TYPE_CFMWS) {
+			cur += c->length;
+			continue;
+		}
+
+		cfmws = cedt_subtable + cur;
+
+		if (cfmws->header.length < sizeof(*cfmws)) {
+			dev_warn_once(dev,
+				      "CFMWS entry skipped:invalid length:%u\n",
+				      cfmws->header.length);
+			cur += c->length;
+			continue;
+		}
+
+		rc = cxl_acpi_cfmws_verify(dev, cfmws);
+		if (rc) {
+			dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
+				cfmws->base_hpa, cfmws->base_hpa +
+				cfmws->window_size - 1);
+			cur += c->length;
+			continue;
+		}
+
+		flags = cfmws_to_decoder_flags(cfmws->restrictions);
+		cxld = devm_cxl_add_decoder(dev, root_port,
+					    CFMWS_INTERLEAVE_WAYS(cfmws),
+					    cfmws->base_hpa, cfmws->window_size,
+					    CFMWS_INTERLEAVE_WAYS(cfmws),
+					    CFMWS_INTERLEAVE_GRANULARITY(cfmws),
+					    CXL_DECODER_EXPANDER,
+					    flags);
+
+		if (IS_ERR(cxld)) {
+			dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
+				cfmws->base_hpa, cfmws->base_hpa +
+				cfmws->window_size - 1);
+		} else {
+			dev_dbg(dev, "add: %s range %#llx-%#llx\n",
+				dev_name(&cxld->dev), cfmws->base_hpa,
+				 cfmws->base_hpa + cfmws->window_size - 1);
+		}
+		cur += c->length;
+	}
+}
+
 static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
 {
 	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
@@ -273,6 +393,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		goto out;
 
+	cxl_add_cfmws_decoders(host, root_port);
+
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
 	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
-- 
2.26.2

