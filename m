Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D5E3ABF3E
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 01:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhFQXSs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 19:18:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:24399 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhFQXSr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 19:18:47 -0400
IronPort-SDR: aBKI0uMnj1LxLGXGVIotNci4D6SSY39WEOYtM2hplM/heVAiDnsCk35jAX1MOQAYEIyO0Hc6v1
 dwHkSCR0FVZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="203441868"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="203441868"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:16:39 -0700
IronPort-SDR: Xn+BEA2PzMy5NcJ8Stv5UKk1zppmcxm4C0NIbEiaI9jX2CbXH5vVeTyWPtaeBAju3CYY8axUbe
 tt55nrBG7eMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="488832475"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2021 16:16:38 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v5 1/2] cxl/acpi: Add the Host Bridge base address to CXL port objects
Date:   Thu, 17 Jun 2021 16:12:15 -0700
Message-Id: <a475ce137b899bc7ae5ba9550b5f198cb29ccbfd.1623968958.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623968958.git.alison.schofield@intel.com>
References: <cover.1623968958.git.alison.schofield@intel.com>
In-Reply-To: <cover.1623968958.git.alison.schofield@intel.com>
References: <cover.1623968958.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The base address for the Host Bridge port component registers is located
in the CXL Host Bridge Structure (CHBS) of the ACPI CXL Early Discovery
Table (CEDT). Retrieve the CHBS for each Host Bridge (ACPI0016 device)
and include that base address in the port object.

Co-developed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 100 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8a723f7f3f73..3afdee8f334a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -8,6 +8,60 @@
 #include <linux/pci.h>
 #include "cxl.h"
 
+static struct acpi_table_header *acpi_cedt;
+
+static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
+{
+	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
+	acpi_size len, cur = 0;
+	void *cedt_subtable;
+
+	len = acpi_cedt->length - sizeof(*acpi_cedt);
+	cedt_subtable = acpi_cedt + 1;
+
+	while (cur < len) {
+		struct acpi_cedt_header *c = cedt_subtable + cur;
+
+		if (c->type != ACPI_CEDT_TYPE_CHBS) {
+			cur += c->length;
+			continue;
+		}
+
+		chbs = cedt_subtable + cur;
+
+		if (chbs->header.length < sizeof(*chbs)) {
+			dev_warn_once(dev,
+				      "CHBS entry skipped: invalid length:%u\n",
+				      chbs->header.length);
+			cur += c->length;
+			continue;
+		}
+
+		if (chbs->uid != uid) {
+			cur += c->length;
+			continue;
+		}
+
+		if (chbs_match) {
+			dev_warn_once(dev,
+				      "CHBS entry skipped: duplicate UID:%u\n",
+				      uid);
+			cur += c->length;
+			continue;
+		}
+
+		chbs_match = chbs;
+		cur += c->length;
+	}
+
+	return chbs_match ? chbs_match : ERR_PTR(-ENODEV);
+}
+
+static resource_size_t get_chbcr(struct acpi_cedt_chbs *chbs)
+{
+	return IS_ERR(chbs) ? CXL_RESOURCE_NONE : chbs->base;
+}
+
 struct cxl_walk_context {
 	struct device *dev;
 	struct pci_bus *root;
@@ -50,6 +104,21 @@ static int match_add_root_ports(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
+static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
+{
+	struct cxl_dport *dport;
+
+	device_lock(&port->dev);
+	list_for_each_entry(dport, &port->dports, list)
+		if (dport->dport == dev) {
+			device_unlock(&port->dev);
+			return dport;
+		}
+
+	device_unlock(&port->dev);
+	return NULL;
+}
+
 static struct acpi_device *to_cxl_host_bridge(struct device *dev)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
@@ -71,6 +140,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct acpi_pci_root *pci_root;
 	struct cxl_walk_context ctx;
 	struct cxl_decoder *cxld;
+	struct cxl_dport *dport;
 	struct cxl_port *port;
 
 	if (!bridge)
@@ -80,8 +150,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (!pci_root)
 		return -ENXIO;
 
-	/* TODO: fold in CEDT.CHBS retrieval */
-	port = devm_cxl_add_port(host, match, CXL_RESOURCE_NONE, root_port);
+	dport = find_dport_by_dev(root_port, match);
+	if (!dport) {
+		dev_dbg(host, "host bridge expected and not found\n");
+		return -ENODEV;
+	}
+
+	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
+				 root_port);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
@@ -120,6 +196,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	int rc;
 	acpi_status status;
 	unsigned long long uid;
+	struct acpi_cedt_chbs *chbs;
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
 	struct acpi_device *bridge = to_cxl_host_bridge(match);
@@ -135,7 +212,12 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		return -ENODEV;
 	}
 
-	rc = cxl_add_dport(root_port, match, uid, CXL_RESOURCE_NONE);
+	chbs = cxl_acpi_match_chbs(host, uid);
+	if (IS_ERR(chbs))
+		dev_dbg(host, "No CHBS found for Host Bridge: %s\n",
+			dev_name(match));
+
+	rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs));
 	if (rc) {
 		dev_err(host, "failed to add downstream port: %s\n",
 			dev_name(match));
@@ -172,6 +254,7 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
+	acpi_status status;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
@@ -181,10 +264,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
 
+	status = acpi_get_table(ACPI_SIG_CEDT, 0, &acpi_cedt);
+	if (ACPI_FAILURE(status))
+		return -ENXIO;
+
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc)
-		return rc;
+		goto out;
 
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
@@ -193,11 +280,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_uport);
 	if (rc)
-		return rc;
+		goto out;
 
 	if (IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
+
+out:
+	acpi_put_table(acpi_cedt);
 	if (rc < 0)
 		return rc;
 	return 0;
-- 
2.26.2

