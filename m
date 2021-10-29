Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C49440393
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhJ2TyR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 15:54:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:30783 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhJ2TyR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 15:54:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="229466497"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="229466497"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:48 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="725334816"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:48 -0700
Subject: [PATCH 4/6] cxl/acpi: Convert CFMWS parsing to ACPI sub-table
 helpers
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 29 Oct 2021 12:51:48 -0700
Message-ID: <163553710810.2509508.14686373989517930921.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The cxl_acpi driver originally open-coded its table parsing since the
ACPI subtable helpers were marked __init and only used in early NUMA
initialization.  Now that those helpers have been exported for driver
usage replace the open-coded solution with the common one.

Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig |    1 
 drivers/cxl/acpi.c  |  234 +++++++++++++++++++--------------------------------
 2 files changed, 88 insertions(+), 147 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index e6de221cc568..67c91378f2dd 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -51,6 +51,7 @@ config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
 	default CXL_BUS
+	select ACPI_TABLE_LIB
 	help
 	  Enable support for host managed device memory (HDM) resources
 	  published by a platform's ACPI CXL memory layout description.  See
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index dadc7f64b9ff..7820082a2746 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -8,8 +8,6 @@
 #include <linux/pci.h>
 #include "cxl.h"
 
-static struct acpi_table_header *acpi_cedt;
-
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
 #define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
@@ -74,134 +72,63 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 	return 0;
 }
 
-static void cxl_add_cfmws_decoders(struct device *dev,
-				   struct cxl_port *root_port)
+struct cxl_cfmws_context {
+	struct device *dev;
+	struct cxl_port *root_port;
+};
+
+static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
+			   const unsigned long end)
 {
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_cfmws_context *ctx = arg;
+	struct cxl_port *root_port = ctx->root_port;
+	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
 	struct cxl_decoder *cxld;
-	acpi_size len, cur = 0;
-	void *cedt_subtable;
-	int rc;
-
-	len = acpi_cedt->length - sizeof(*acpi_cedt);
-	cedt_subtable = acpi_cedt + 1;
-
-	while (cur < len) {
-		struct acpi_cedt_header *c = cedt_subtable + cur;
-		int i;
-
-		if (c->type != ACPI_CEDT_TYPE_CFMWS) {
-			cur += c->length;
-			continue;
-		}
+	int rc, i;
 
-		cfmws = cedt_subtable + cur;
+	cfmws = (struct acpi_cedt_cfmws *) header;
 
-		if (cfmws->header.length < sizeof(*cfmws)) {
-			dev_warn_once(dev,
-				      "CFMWS entry skipped:invalid length:%u\n",
-				      cfmws->header.length);
-			cur += c->length;
-			continue;
-		}
-
-		rc = cxl_acpi_cfmws_verify(dev, cfmws);
-		if (rc) {
-			dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
-				cfmws->base_hpa, cfmws->base_hpa +
-				cfmws->window_size - 1);
-			cur += c->length;
-			continue;
-		}
-
-		for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
-			target_map[i] = cfmws->interleave_targets[i];
-
-		cxld = cxl_decoder_alloc(root_port,
-					 CFMWS_INTERLEAVE_WAYS(cfmws));
-		if (IS_ERR(cxld))
-			goto next;
-
-		cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-		cxld->target_type = CXL_DECODER_EXPANDER;
-		cxld->range = (struct range) {
-			.start = cfmws->base_hpa,
-			.end = cfmws->base_hpa + cfmws->window_size - 1,
-		};
-		cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
-		cxld->interleave_granularity =
-			CFMWS_INTERLEAVE_GRANULARITY(cfmws);
-
-		rc = cxl_decoder_add(cxld, target_map);
-		if (rc)
-			put_device(&cxld->dev);
-		else
-			rc = cxl_decoder_autoremove(dev, cxld);
-		if (rc) {
-			dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
-				cfmws->base_hpa, cfmws->base_hpa +
-				cfmws->window_size - 1);
-			goto next;
-		}
-		dev_dbg(dev, "add: %s range %#llx-%#llx\n",
-			dev_name(&cxld->dev), cfmws->base_hpa,
+	rc = cxl_acpi_cfmws_verify(dev, cfmws);
+	if (rc) {
+		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
+			cfmws->base_hpa,
 			cfmws->base_hpa + cfmws->window_size - 1);
-next:
-		cur += c->length;
+		return 0;
 	}
-}
-
-static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
-{
-	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
-	acpi_size len, cur = 0;
-	void *cedt_subtable;
 
-	len = acpi_cedt->length - sizeof(*acpi_cedt);
-	cedt_subtable = acpi_cedt + 1;
+	for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
+		target_map[i] = cfmws->interleave_targets[i];
 
-	while (cur < len) {
-		struct acpi_cedt_header *c = cedt_subtable + cur;
-
-		if (c->type != ACPI_CEDT_TYPE_CHBS) {
-			cur += c->length;
-			continue;
-		}
-
-		chbs = cedt_subtable + cur;
-
-		if (chbs->header.length < sizeof(*chbs)) {
-			dev_warn_once(dev,
-				      "CHBS entry skipped: invalid length:%u\n",
-				      chbs->header.length);
-			cur += c->length;
-			continue;
-		}
-
-		if (chbs->uid != uid) {
-			cur += c->length;
-			continue;
-		}
+	cxld = cxl_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
+	if (IS_ERR(cxld))
+		return 0;
 
-		if (chbs_match) {
-			dev_warn_once(dev,
-				      "CHBS entry skipped: duplicate UID:%u\n",
-				      uid);
-			cur += c->length;
-			continue;
-		}
+	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->range = (struct range){
+		.start = cfmws->base_hpa,
+		.end = cfmws->base_hpa + cfmws->window_size - 1,
+	};
+	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
+	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
-		chbs_match = chbs;
-		cur += c->length;
+	rc = cxl_decoder_add(cxld, target_map);
+	if (rc)
+		put_device(&cxld->dev);
+	else
+		rc = cxl_decoder_autoremove(dev, cxld);
+	if (rc) {
+		dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
+			cfmws->base_hpa,
+			cfmws->base_hpa + cfmws->window_size - 1);
+		return 0;
 	}
+	dev_dbg(dev, "add: %s range %#llx-%#llx\n", dev_name(&cxld->dev),
+		cfmws->base_hpa, cfmws->base_hpa + cfmws->window_size - 1);
 
-	return chbs_match ? chbs_match : ERR_PTR(-ENODEV);
-}
-
-static resource_size_t get_chbcr(struct acpi_cedt_chbs *chbs)
-{
-	return IS_ERR(chbs) ? CXL_RESOURCE_NONE : chbs->base;
+	return 0;
 }
 
 __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
@@ -355,12 +282,35 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	return rc;
 }
 
+struct cxl_chbs_context {
+	unsigned long long uid;
+	resource_size_t chbcr;
+};
+
+static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
+			 const unsigned long end)
+{
+	struct cxl_chbs_context *ctx = arg;
+	struct acpi_cedt_chbs *chbs;
+
+	if (ctx->chbcr)
+		return 0;
+
+	chbs = (struct acpi_cedt_chbs *) header;
+
+	if (ctx->uid != chbs->uid)
+		return 0;
+	ctx->chbcr = chbs->base;
+
+	return 0;
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	int rc;
 	acpi_status status;
 	unsigned long long uid;
-	struct acpi_cedt_chbs *chbs;
+	struct cxl_chbs_context ctx;
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
@@ -376,14 +326,18 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		return -ENODEV;
 	}
 
-	chbs = cxl_acpi_match_chbs(host, uid);
-	if (IS_ERR(chbs)) {
+	ctx = (struct cxl_chbs_context) {
+		.uid = uid,
+	};
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
+
+	if (ctx.chbcr == 0) {
 		dev_warn(host, "No CHBS found for Host Bridge: %s\n",
 			 dev_name(match));
 		return 0;
 	}
 
-	rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs));
+	rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
 	if (rc) {
 		dev_err(host, "failed to add downstream port: %s\n",
 			dev_name(match));
@@ -417,40 +371,29 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 	return 1;
 }
 
-static u32 cedt_instance(struct platform_device *pdev)
-{
-	const bool *native_acpi0017 = acpi_device_get_match_data(&pdev->dev);
-
-	if (native_acpi0017 && *native_acpi0017)
-		return 0;
-
-	/* for cxl_test request a non-canonical instance */
-	return U32_MAX;
-}
-
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
-	acpi_status status;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
+	struct cxl_cfmws_context ctx;
 
 	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
 
-	status = acpi_get_table(ACPI_SIG_CEDT, cedt_instance(pdev), &acpi_cedt);
-	if (ACPI_FAILURE(status))
-		return -ENXIO;
-
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
-	if (rc)
-		goto out;
+	if (rc < 0)
+		return rc;
 
-	cxl_add_cfmws_decoders(host, root_port);
+	ctx = (struct cxl_cfmws_context) {
+		.dev = host,
+		.root_port = root_port,
+	};
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
 
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
@@ -458,24 +401,20 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	 */
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_uport);
-	if (rc)
-		goto out;
+	if (rc < 0)
+		return rc;
 
 	if (IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
-
-out:
-	acpi_put_table(acpi_cedt);
 	if (rc < 0)
 		return rc;
+
 	return 0;
 }
 
-static bool native_acpi0017 = true;
-
 static const struct acpi_device_id cxl_acpi_ids[] = {
-	{ "ACPI0017", (unsigned long) &native_acpi0017 },
+	{ "ACPI0017" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
@@ -491,3 +430,4 @@ static struct platform_driver cxl_acpi_driver = {
 module_platform_driver(cxl_acpi_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
+MODULE_IMPORT_NS(ACPI);

